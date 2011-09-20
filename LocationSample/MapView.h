//
//  MapView.h
//  LocationSample
//
//  Created by Daniel Barden on 9/20/11.
//  Copyright (c) 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"

@interface MapView : UIViewController <MKMapViewDelegate>

@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) Venue *venue;
@end
