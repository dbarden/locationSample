//
//  Venue.h
//  LocationSample
//
//  Created by Daniel Barden on 9/20/11.
//  Copyright (c) 2011 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Venue : NSObject {
@private
	double _distance;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *photos;
@property (nonatomic, retain) CLLocation *location;
@property (nonatomic, retain) NSString *description;

- (id)initWithName:(NSString *)name withLatitude:(double)latitude withLongitude:(double)longitude;
- (void)updateDistance:(CLLocation *)coordinate;
- (NSString *)distance;

@end
