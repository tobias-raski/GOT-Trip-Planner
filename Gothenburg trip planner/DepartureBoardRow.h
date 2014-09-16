//
//  DepartureBoardRow.h
//  Gothenburg trip planner
//
//  Created by Tobias on 2014-08-01.
//  Copyright (c) 2014 Tobias. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DepartureBoardRow : NSObject

@property (nonatomic, strong) NSString *sname;
@property (nonatomic, strong) NSString *destination;
@property (nonatomic, strong) NSString *minutesUntilNext;
@property (nonatomic, strong) NSString *minutesUntilSecondNext;
@property (nonatomic, strong) NSString *fgColor;
@property (nonatomic, strong) NSString *bgColor;

@end
