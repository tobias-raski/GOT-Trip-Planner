//
//  RowView.m
//  Gothenburg trip planner
//
//  Created by Tobias on 2014-08-03.
//  Copyright (c) 2014 Tobias. All rights reserved.
//

#import "RowView.h"
#import "DepartureBoardRow.h"
#import "RSVerticallyCenteredTextFieldCell.h"

@implementation RowView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(NSRect)frame andDepartureBoardRow:(DepartureBoardRow *)boardRow andBackGroundColor:(NSColor *)color{
    self = [super initWithFrame:frame];
    if (self) {
        _bgColor = color;
        int y =[self frame].size.height/2 - 19;
        NSRect rect = NSMakeRect(15, y, 39, 39);
        NSView *image = [[NSView alloc] initWithFrame:rect];
        
        
        // Add image view
        [image setWantsLayer:YES];
        NSColor *bgColor = [RowView colorWithHexColorString:[boardRow.fgColor substringFromIndex:1]];
        [image.layer setBackgroundColor:[bgColor CGColor]];
        [self addSubview:image];
        
        // Add sname textField
        NSTextField *snameTextField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 39, 39)];
        RSVerticallyCenteredTextFieldCell * cell = [[RSVerticallyCenteredTextFieldCell alloc] init];
        [cell setAlignment:NSCenterTextAlignment];
        [snameTextField setCell:cell];
        [snameTextField setFont:[NSFont fontWithName:@"Helvetica-Bold" size:16]];
        NSColor *fgColor = [RowView colorWithHexColorString:[boardRow.bgColor substringFromIndex:1]];
        [snameTextField setTextColor:fgColor];
        snameTextField.bezeled         = NO;
        snameTextField.editable        = NO;
        snameTextField.drawsBackground = NO;
        [snameTextField setStringValue:boardRow.sname];
        [image addSubview:snameTextField];
        
        //Add destination text field
        NSTextField *destTextField = [[NSTextField alloc] initWithFrame:NSMakeRect(69, y, 200, 39)];
        RSVerticallyCenteredTextFieldCell * cell2 = [[RSVerticallyCenteredTextFieldCell alloc] init];
        //[cell2 setAlignment:NSCenterTextAlignment];
        [destTextField setCell:cell2];
        [destTextField setTextColor:[NSColor whiteColor]];
        [destTextField setStringValue:boardRow.destination];
        [self addSubview:destTextField];
        
        //Add next departure text field
        NSTextField *nextTextField = [[NSTextField alloc] initWithFrame:NSMakeRect(284, y, 30, 39)];
        RSVerticallyCenteredTextFieldCell * cell3 = [[RSVerticallyCenteredTextFieldCell alloc] init];
        //[cell3 setAlignment:NSCenterTextAlignment];
        [nextTextField setCell:cell3];
        [nextTextField setTextColor:[NSColor whiteColor]];
        if (boardRow.minutesUntilNext)
            [nextTextField setStringValue:boardRow.minutesUntilNext];
        else
            [nextTextField setStringValue:@""];
        
        [self addSubview:nextTextField];
        
        //Add second next departure text field
        NSTextField *secondNextTextField = [[NSTextField alloc] initWithFrame:NSMakeRect(330, y, 30, 39)];
        RSVerticallyCenteredTextFieldCell * cell4 = [[RSVerticallyCenteredTextFieldCell alloc] init];
        //[cell4 setAlignment:NSCenterTextAlignment];
        [secondNextTextField setCell:cell4];
        [secondNextTextField setTextColor:[NSColor whiteColor]];
        if (boardRow.minutesUntilSecondNext)
            [secondNextTextField setStringValue:boardRow.minutesUntilSecondNext];
        else
            [secondNextTextField setStringValue:@""];
        
        [self addSubview:secondNextTextField];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [_bgColor setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

+ (NSColor*)colorWithHexColorString:(NSString*)inColorString
{
    NSColor* result = nil;
    unsigned colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner* scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char)(colorCode >> 16);
    greenByte = (unsigned char)(colorCode >> 8);
    blueByte = (unsigned char)(colorCode); // masks off high bits
    
    result = [NSColor
              colorWithCalibratedRed:(CGFloat)redByte / 0xff
              green:(CGFloat)greenByte / 0xff
              blue:(CGFloat)blueByte / 0xff
              alpha:1.0];
    return result;
}


@end
