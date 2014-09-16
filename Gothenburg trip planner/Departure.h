//
//  Departure.h
//  Gothenburg trip planner
//
//  Created by Tobias on 2014-07-31.
//  Copyright (c) 2014 Tobias. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Departure : NSObject

@property (nonatomic, strong) NSString *sname;
@property (nonatomic, strong) NSString *direction;

@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSString *rtTime;
@property (nonatomic, strong) NSString *rtDate;

@property (nonatomic, strong) NSString *fgColor;
@property (nonatomic, strong) NSString *bgColor;


@end
