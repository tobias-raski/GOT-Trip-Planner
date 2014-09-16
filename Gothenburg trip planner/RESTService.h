//
//  RESTService.h
//  Gothenburg trip planner
//
//  Created by Tobias on 2014-07-31.
//  Copyright (c) 2014 Tobias. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchTripViewController;

@interface RESTService : NSObject {
    id delegate;
}

- (void)fetchLocationMappingsForString:(NSString *)input;
- (void)fetchDeparturesForId:(NSString *)stopId;
- (void)setDepartureFetchDelegate:(SearchTripViewController *)delegate;

- (void) autoRequestObject:(NSTextView *)obj;
- (NSArray *) getLatestStopLocations;


@property NSTextView *autoRequestObject;

@end
