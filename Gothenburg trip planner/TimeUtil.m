//
//  TimeUtil.m
//  Gothenburg trip planner
//
//  Created by Tobias on 2014-08-01.
//  Copyright (c) 2014 Tobias. All rights reserved.
//

#import "TimeUtil.h"

@implementation TimeUtil

+ (BOOL)dateAndTimeString:(NSString *)dateAndTimeString isAfterDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-dd-MM HH:mm"];
    
    NSDate *givenDate = [dateFormatter dateFromString:dateAndTimeString];
    
    return [givenDate compare:date] == NSOrderedDescending;
}


+ (int)timeStringdifferenceInMinutesToNow:(NSString *)timeString  {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"sv_SE"]];
    
    NSString * current = [dateFormatter stringFromDate:[NSDate date]];
    
    
    NSDate *d1 = [dateFormatter dateFromString:timeString];
    NSDate *d2 = [dateFormatter dateFromString:current];

    NSTimeInterval timeDifference = [d1 timeIntervalSinceDate:d2];
    
    return timeDifference / 60;
}


@end
