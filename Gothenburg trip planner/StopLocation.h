//
//  StopLocation.h
//  Gothenburg trip planner
//
//  Created by Tobias on 2014-07-31.
//  Copyright (c) 2014 Tobias. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StopLocation : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *id;

@end
