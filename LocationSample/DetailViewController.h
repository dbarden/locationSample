//
//  DetailViewController.h
//  LocationSample
//
//  Created by Daniel Barden on 9/20/11.
//  Copyright (c) 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Venue.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Venue *venue;

@property (strong, nonatomic) IBOutlet UILabel *name;

@property (nonatomic, retain) IBOutlet UITextView *description;


- (IBAction)openMap:(id)sender;
- (IBAction)openPhotos:(id)sender;
@end
