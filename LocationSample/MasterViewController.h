//
//  MasterViewController.h
//  LocationSample
//
//  Created by Daniel Barden on 9/20/11.
//  Copyright (c) 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (nonatomic, retain) NSArray *venues;

@property (nonatomic, retain) CLLocationManager *clManager;
@end
