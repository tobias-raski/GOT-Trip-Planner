//
//  TimeUtil.h
//  Gothenburg trip planner
//
//  Created by Tobias on 2014-08-01.
//  Copyright (c) 2014 Tobias. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeUtil : NSObject

+ (BOOL)dateAndTimeString:(NSString *)dateAndTimeString isAfterDate:(NSDate *)date;

+ (int)timeStringdifferenceInMinutesToNow:(NSString *)timeString;


@end
