//
//  IPMenulet.m
//  Gothenburg trip planner
//
//  Created by Tobias on 2014-07-29.
//  Copyright (c) 2014 Tobias. All rights reserved.
//

#import "IPMenulet.h"
#import "CustomWindow.h"
#import "SearchTripViewController.h"
#import "RestKit/Restkit.h"
#import "StopLocation.h"
#import "MAAttachedWindow.h"

@interface IPMenulet()
{
@private
    bool toogle;
}
@end


@implementation IPMenulet

@synthesize statusItem;
@synthesize ipMenuItem;
@synthesize theMenu;
@synthesize updateTimer;
@synthesize viewController = _viewController;


- (NSWindow*) getNewWindow {
    
    
    
    return newWindow;
}



- (void)awakeFromNib
{
    statusItem = [[NSStatusBar systemStatusBar]
                  statusItemWithLength:21];
    [statusItem setHighlightMode:YES];
    [statusItem setTitle:@""];
    [statusItem setEnabled:YES];
    [statusItem setToolTip:@"IPMenulet"];
    
    [statusItem setAction:@selector(popupWindow:)];
    [statusItem setTarget:self];
    
    
    NSBundle *bundle=[NSBundle mainBundle];
    
    NSString *path=[bundle pathForResource:@"bus" ofType:@"png"];
    
    NSImage *image=[[NSImage alloc] initWithContentsOfFile:path];
    
    [statusItem setImage:image];
    
    self.viewController = [[SearchTripViewController alloc] initWithNibName:@"SearchTripViewController" bundle:nil];
    [[self.viewController scrollView] setBorderType:NSNoBorder];
}


-(IBAction)popupWindow:(id)sender {
    
    NSPoint mouseLoc = [NSEvent mouseLocation];

    
    if (newWindow) {
        NSNotificationCenter* theCenter = [NSNotificationCenter defaultCenter];
        [theCenter removeObserver:self];
        [self closeMainWindow];
    }
    else {
        newWindow = [[MAAttachedWindow alloc] initWithView:self.viewController.view attachedToPoint:NSMakePoint(mouseLoc.x, mouseLoc.y)];
        [newWindow setBorderWidth:1];
        [newWindow setArrowBaseWidth:30];
        
        
        [newWindow setBackgroundColor:[NSColor colorWithDeviceRed:0.200 green:0.196 blue:0.200 alpha:1]];
        [newWindow setBorderColor:[NSColor blackColor]];
        [newWindow setHasArrow:YES];
        NSNotificationCenter* theCenter = [NSNotificationCenter defaultCenter];
        [theCenter addObserver:self selector:@selector(closeMainWindow) name:NSWindowDidResignKeyNotification object:newWindow];
        [theCenter addObserver:self selector:@selector(closeMainWindow) name:NSWindowDidResignMainNotification object:newWindow];


        
        [self.viewController.scrollView setBorderType:NSNoBorder];
        [newWindow makeKeyAndOrderFront:NSApp];
        [newWindow setLevel:NSFloatingWindowLevel];
        
        [[NSRunningApplication currentApplication] activateWithOptions: NSApplicationActivateIgnoringOtherApps];
    }
}

-(void)closeMainWindow {
    @synchronized(self) {
        if (newWindow) {
            [newWindow orderOut:nil];
            newWindow = nil;
            NSNotificationCenter* theCenter = [NSNotificationCenter defaultCenter];
            [theCenter removeObserver:self];
        }
    }
}

@end
