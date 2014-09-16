//
//  SearchTripViewController.h
//  Gothenburg trip planner
//
//  Created by Tobias on 2014-07-31.
//  Copyright (c) 2014 Tobias. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class RESTService;

@interface SearchTripViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (strong) RESTService *restService;
@property (nonatomic, strong) NSArray* departureRows;

@property (weak) IBOutlet NSSearchField *searchField;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSScrollView *scrollView;


-(IBAction) searchFieldAction:(id)sender;

@end
