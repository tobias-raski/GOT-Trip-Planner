//
//  SearchTripViewController.m
//  Gothenburg trip planner
//
//  Created by Tobias on 2014-07-31.
//  Copyright (c) 2014 Tobias. All rights reserved.
//

#import "SearchTripViewController.h"
#import "RESTService.h"
#import "StopLocation.h"
#import "Departure.h"
#import "DepartureBoardRow.h"
#import "RSVerticallyCenteredTextFieldCell.h"
#import "RowView.h"

@interface SearchTripViewController () {
    
    NSMutableDictionary *stopDictionary;
    NSProgressIndicator *progress;
    NSString *currentlyChosenStopName;
    NSTimer *departureUpdateTimer;
}

@end

@implementation SearchTripViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _restService = [[RESTService alloc] init];
        stopDictionary = [[NSMutableDictionary alloc] init];
        
    }
    return self;
}

-(void)loadView {
    [super loadView];
}


- (void)controlTextDidChange:(NSNotification *)notification {
    
    NSString *string = [_searchField stringValue];
    if ([string length] >= 2) {
        [_restService fetchLocationMappingsForString:string];
        
        if ([_restService autoRequestObject]) {
            return;
        }
        else {
            NSTextView *autoRequestObject = [[notification userInfo] objectForKey:@"NSFieldEditor"];
            [_restService autoRequestObject:autoRequestObject];
        }
    }
}

- (void)setDepartureRows:(NSArray *)departureRows {
    if (progress) {
        [progress stopAnimation:self];
        [progress removeFromSuperview];
        progress = nil;
    }
    _departureRows = departureRows;
    [_tableView reloadData];
}

-(IBAction) searchFieldAction:(id)sender {
    if(departureUpdateTimer) {
        [departureUpdateTimer invalidate];
        departureUpdateTimer = nil;
    }
    [_restService setDepartureFetchDelegate:self];
    NSString *inputString = [_searchField stringValue];
    currentlyChosenStopName = inputString;
    [self updateDeparturesForStopName];
    [self initTimer];
    
}

-(void)updateDeparturesForStopName {
    if ([stopDictionary valueForKey:currentlyChosenStopName]) {
        if (!progress) {
            progress = [[NSProgressIndicator alloc] init];
            [progress setStyle:NSProgressIndicatorSpinningStyle];
            [progress setFrame:self.view.frame];
            
            [self.view addSubview:progress];
            [progress startAnimation:self];
        }
        [_restService fetchDeparturesForId:[stopDictionary valueForKey:currentlyChosenStopName]];
    }
}

-(void)initTimer {
    departureUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:20.0
                                                            target:self
                                                          selector:@selector(updateDeparturesForStopName)
                                                          userInfo:nil
                                                           repeats:YES];
}

- (NSArray *)control:(NSControl *)control textView:(NSTextView *)textView completions:(NSArray *)words
 forPartialWordRange:(NSRange)charRange indexOfSelectedItem:(long*)index
{
    NSMutableArray *matches = [NSMutableArray array];
    NSArray *stopLocations = [_restService getLatestStopLocations];
    StopLocation *stop;
    
    for (int i = 0; i < [stopLocations count]; i++) {
        stop = [stopLocations objectAtIndex:i];
        [matches addObject:stop.name];
        [stopDictionary setObject:stop.id forKey:stop.name];
    }
    
    *index = -1;
    
    return matches;
}


-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [_departureRows count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    DepartureBoardRow *boardRow = _departureRows[row];
    NSString *identifier = [tableColumn identifier];
    
    if ([identifier isEqualToString:@"MainCell"]) {
        
        NSColor *color = [NSColor colorWithDeviceRed:0.200 green:0.196 blue:0.200 alpha:1];
        if (row % 2 == 0) {
            color = [NSColor colorWithDeviceRed:0.161 green:0.176 blue:0.192 alpha:1];
        }
        else {
            
        }
        RowView *view = [[RowView alloc] initWithFrame:NSMakeRect(0, 0, 0, 59) andDepartureBoardRow:boardRow andBackGroundColor:color];

        
        /*
         Alternating colors;
         [UIColor colorWithRed:0.651 green:0.667 blue:0.678 alpha:1]
         */
        
        
        return view;
    }
    return nil;
}




@end
