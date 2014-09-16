//
//  RESTService.m
//  Gothenburg trip planner
//
//  Created by Tobias on 2014-07-31.
//  Copyright (c) 2014 Tobias. All rights reserved.
//

#import "RESTService.h"
#import "RestKit/Restkit.h"
#import "StopLocation.h"
#import "Departure.h"
#import "DepartureBoardRow.h"
#import "TimeUtil.h"
#import "SearchTripViewController.h"

@interface RESTService () {
    __block NSArray *stopLocations;
}

@end


@implementation RESTService

@synthesize autoRequestObject = _autoRequestObject;


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureRestKit];
    }
    return self;
}


- (NSArray *) getLatestStopLocations {
    return stopLocations;
}

- (NSTextView *)autoReqeustObject {
    return _autoRequestObject;
}

- (void)autoRequestObject:(NSTextView *)obj {
    _autoRequestObject = obj;
}


- (void)fetchLocationMappingsForString:(NSString *)input
{
    
    stopLocations = [[NSArray alloc] init];
    
    NSDictionary *queryParams = @{@"authKey" : @"13e63bfd-82dc-4891-967b-aacf58e4f8ca",
                                  @"format" : @"json",
                                  @"input" : input};
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/bin/rest.exe/v1/location.name"
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  stopLocations = mappingResult.array;
                                                  if (_autoRequestObject) {
                                                      [_autoRequestObject complete:nil];
                                                      _autoRequestObject = nil;
                                                  }
                                                  
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"What do you mean by 'there is no coffee?': %@", error);
                                              }];

}

- (void)setDepartureFetchDelegate:(id)aDelegate  {
    delegate = aDelegate;
}


- (void)fetchDeparturesForId:(NSString *)stopId
{
    
    NSDictionary *queryParams = @{@"authKey" : @"13e63bfd-82dc-4891-967b-aacf58e4f8ca",
                                  @"format" : @"json",
                                  @"id" : stopId,
                                  @"timeSpan" : @"120"};
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/bin/rest.exe/v1/departureBoard"
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  NSArray *departureBoardsRows = [self departuresToDepartureBoardRows:mappingResult.array];
                                                  [delegate setDepartureRows:departureBoardsRows];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"What do you mean by 'there is no coffee?': %@", error);
                                              }];
}




- (void)configureRestKit
{
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://api.vasttrafik.se"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup two object mappings
    RKObjectMapping *locationMapping = [RKObjectMapping mappingForClass:[StopLocation class]];
    [locationMapping addAttributeMappingsFromArray:@[@"name", @"lon", @"lat", @"id"]];

    
    RKObjectMapping *departureMapping = [RKObjectMapping mappingForClass:[Departure class]];
    [departureMapping addAttributeMappingsFromArray:@[@"sname", @"direction", @"time", @"date", @"rtTime", @"fgColor", @"bgColor"]];
    
    // register mappings with the provider using two response descriptor
    RKResponseDescriptor *responseDescriptor1 =
    [RKResponseDescriptor responseDescriptorWithMapping:locationMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/bin/rest.exe/v1/location.name"
                                                keyPath:@"LocationList.StopLocation"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    RKResponseDescriptor *responseDescriptor2 =
    [RKResponseDescriptor responseDescriptorWithMapping:departureMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/bin/rest.exe/v1/departureBoard"
                                                keyPath:@"DepartureBoard.Departure"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor1];
    [objectManager addResponseDescriptor:responseDescriptor2];
}

- (NSArray *)departuresToDepartureBoardRows:(NSArray *)departures {
    NSMutableArray *departureRows = [[NSMutableArray alloc] init];
    
    if ([departures count] == 0) {
        return departureRows;
    }

    //Departure *dep = [departures objectAtIndex:0];
    //[departureRows addObject:[self createDepartureBoardRow:dep]];
    
    for (int i = 0; i < [departures count]; i++) {
        Departure *dep = [departures objectAtIndex:i];
        BOOL match = NO;
        for (int j = 0; j < [departureRows count]; j++) {
            DepartureBoardRow *row = [departureRows objectAtIndex:j];
            if ([[row sname] isEqualToString:[dep sname]] && [[row destination] isEqualToString:[dep direction]]) {
                match = YES;
                if (!row.minutesUntilSecondNext) {
                    // Add second departure
                    int secondNext;
                    if ([dep rtTime]) {
                        secondNext = [TimeUtil timeStringdifferenceInMinutesToNow:[dep rtTime]];
                    }
                    else {
                        secondNext = [TimeUtil timeStringdifferenceInMinutesToNow:[dep time]];
                    }
                    row.minutesUntilSecondNext = [NSString stringWithFormat:@"%d", secondNext];
                }
            }
        }
        if (!match) {
            DepartureBoardRow *row = [self createDepartureBoardRow:dep];
            if (row) {
                [departureRows addObject:row];
            }
        }
    }
    return departureRows;
}

- (DepartureBoardRow *)createDepartureBoardRow:(Departure *)departure {
    DepartureBoardRow * row = [[DepartureBoardRow alloc] init];
    row.sname = departure.sname;
    row.destination = departure.direction;
    row.fgColor = departure.fgColor;
    row.bgColor = departure.bgColor;
    int next;
    if ([departure rtTime]) {
        next = [TimeUtil timeStringdifferenceInMinutesToNow:[departure rtTime]];
    }
    else {
        next = [TimeUtil timeStringdifferenceInMinutesToNow:[departure time]];
    }
    if (next < 0) {
        return nil;
    }
    
    if (next == 0) {
        row.minutesUntilNext = @"Nu";
    } else {
        row.minutesUntilNext = [NSString stringWithFormat:@"%d", next];
    }
    return row;
}


@end
