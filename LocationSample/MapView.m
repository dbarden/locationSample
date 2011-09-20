//
//  MapView.m
//  LocationSample
//
//  Created by Daniel Barden on 9/20/11.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "MapView.h"

@interface MyAnnotation : NSObject <MKAnnotation> 
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@end

@implementation MyAnnotation
@synthesize coordinate = _coordinate;
@synthesize title = _title;

@end

@implementation MapView
@synthesize mapView = _mapView;
@synthesize venue = _venue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    self.title = _venue.name;
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    MKCoordinateRegion region;
    region.center.latitude = _venue.location.coordinate.latitude;
    region.center.longitude = _venue.location.coordinate.longitude;
    region.span.latitudeDelta = 0.1;
    region.span.longitudeDelta = 0.1;
    
    MyAnnotation *annotation = [[MyAnnotation alloc] init];
    annotation.coordinate = _venue.location.coordinate;
    annotation.title = _venue.name;
    
    [_mapView setRegion:region];
    [_mapView addAnnotation:annotation];
    [self.view addSubview:_mapView];
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
