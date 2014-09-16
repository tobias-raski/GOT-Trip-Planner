//
//  RowView.h
//  Gothenburg trip planner
//
//  Created by Tobias on 2014-08-03.
//  Copyright (c) 2014 Tobias. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class DepartureBoardRow;

@interface RowView : NSTableCellView


@property (strong) NSColor *bgColor;

- (id)initWithFrame:(NSRect)frame andDepartureBoardRow:(DepartureBoardRow *)boardRow andBackGroundColor:(NSColor *)color;

- (void)createContent;

@end
