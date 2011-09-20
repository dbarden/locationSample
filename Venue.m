//
//  Venue.m
//  LocationSample
//
//  Created by Daniel Barden on 9/20/11.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "Venue.h"

@implementation Venue
@synthesize name = _name;
@synthesize photos = _photos;
@synthesize location = _location;
@synthesize description = _description;

#pragma mark - Initializers

- (id)init 
{
	if ((self =[super init])) {

	}
	return self;
}

- (id)initWithName:(NSString *)name 
{
	if ((self = [self init])) {
		self.name = name;
	}
    return self;
}

- (id)initWithName:(NSString *)name withLatitude:(double)latitude withLongitude:(double)longitude
{
    if ((self = [super init])) {
        self.name = name;
        _location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    }
    return self;
}

#pragma mark - Location Methods
- (void)updateDistance:(CLLocation *)coordinate {
    double distance = [_location distanceFromLocation:coordinate];
	_distance = distance;
	NSLog(@"distance %g", _distance);
}

- (NSString *)distance
{
	if (_distance == 0)
		return nil;
	return [NSString stringWithFormat:@"%g metros", _distance];
}

- (void)dealloc 
{
    [_location release];
    [_name release];
    [super dealloc];
}
@end
