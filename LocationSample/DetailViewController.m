//
//  DetailViewController.m
//  LocationSample
//
//  Created by Daniel Barden on 9/20/11.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "DetailViewController.h"
#import "MapView.h"
#import "PhotosController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize venue = _venue;
@synthesize name = _name;
@synthesize description = _description;

- (void)dealloc
{
    [_name release];
    [_venue release];
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_venue != newDetailItem) {
        [_venue release]; 
        _venue = [newDetailItem retain]; 

        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.venue) {
        self.name.text = _venue.name;
		self.description.text = _venue.description;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
	self.navigationController.navigationBar.translucent = NO;
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
   [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = _venue.name;
    }
    return self;
}

#pragma mark - IBActions
- (IBAction)openMap:(id)sender
{
	MapView *map = [[MapView alloc] init];
	map.venue = _venue;
	[self.navigationController pushViewController:map animated:YES];
	[map release];
}

- (IBAction)openPhotos:(id)sender
{
	PhotosController *photos = [[PhotosController alloc] init];
	photos.venue = _venue;
	[self.navigationController pushViewController:photos animated:YES];
	[photos release];
}
@end
