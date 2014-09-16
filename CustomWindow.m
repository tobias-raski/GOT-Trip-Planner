//
//  CustomWindow.m
//  Gothenburg trip planner
//
//  Created by Tobias on 2014-07-30.
//  Copyright (c) 2014 Tobias. All rights reserved.
//

#import "CustomWindow.h"

#define MAATTACHEDWINDOW_DEFAULT_BACKGROUND_COLOR [NSColor colorWithCalibratedWhite:0.1 alpha:0.75]
#define MAATTACHEDWINDOW_DEFAULT_BORDER_COLOR [NSColor whiteColor]
#define MAATTACHEDWINDOW_SCALE_FACTOR [[NSScreen mainScreen] userSpaceScaleFactor]

@implementation CustomWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
    
    self = [super initWithContentRect:contentRect
                                 styleMask:aStyle
                                   backing:bufferingType
                                 defer:flag];
    
    return self;
}

- (BOOL)canBecomeKeyWindow
{
    return YES;
}


@end
