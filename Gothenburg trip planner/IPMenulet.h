//
//  IPMenulet.h
//  Gothenburg trip planner
//
//  Created by Tobias on 2014-07-29.
//  Copyright (c) 2014 Tobias. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomWindow.h"
#import "SearchTripViewController.h"
#import "MAAttachedWindow.h"

@interface IPMenulet : NSObject {
    MAAttachedWindow *newWindow;
}

@property (nonatomic, strong) NSArray *stopLocations;

@property (strong) NSStatusItem *statusItem;


@property (weak) IBOutlet NSMenu *theMenu;

    
@property (strong) NSMenuItem *ipMenuItem;
@property (strong) NSTimer *updateTimer;

@property (strong) SearchTripViewController *viewController;


@end
