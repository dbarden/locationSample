//
//  MasterViewController.m
//  LocationSample
//
//  Created by Daniel Barden on 9/20/11.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "MasterViewController.h"
#import <CoreLocation/CoreLocation.h>

#import "DetailViewController.h"
#import "Venue.h"

@implementation MasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize venues = _venues;
@synthesize clManager = _clManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    return self;
}
							
- (void)dealloc
{
    [_detailViewController release];
    [super dealloc];
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
	
	UIBarButtonItem *barbutton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(getLocation)];
	self.navigationItem.rightBarButtonItem = barbutton;

	_clManager = [[CLLocationManager alloc] init];
	_clManager.delegate = self;

	Venue *venue = [[Venue alloc] initWithName:@"Marinha" withLatitude:-30.05 withLongitude:-51.20];
	venue.description = @"Este parque esta jogado as tracasasdajsdlkajsdlja asdasasad asdaksjdasd asdlkasjdasd asdlkasdas dasdk asldk asdasldkasdklsad asdkalf asklf dfsdlkfsdlfksd fsdklf sdfklsdfksdlfksdlfsdkfsdlkf sdlfksdlfksdklf sdlfkdsf dsflksdkf dsflsdkf sdlkflsdkflsdkflsdkf sdfklsdflksdflksdlfksdfsdlkf sklfsdfk sdlfsdklfsdkflskd fslkdf sdlkf sldkfklsdfdslfksdlfksdflksdf lskdf sldkflsdkfsdklfksdlfsdlkfsdlk fdslkfsldkflsdkflsdkfsdklf dlskf lsdkfsdlfskdflsdlfksdfsdlkf sdklfdslkfklsd flksd flksdkflsdfkldskfdslfkdslfkdsfldskfsdlfksdlfksdlf sdflk dsf";
	NSArray *photos = [[NSArray alloc] initWithObjects:@"marinha1.jpg", @"marinha2.jpg", @"marinha3.jpg", nil];
	venue.photos = photos;
	[photos release];
	
	NSArray *tmpVenues = [[NSArray alloc] initWithObjects:venue, nil];
	self.venues = tmpVenues;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
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

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    // Configure the cell.
	Venue *venue = [self.venues objectAtIndex:indexPath.row];
	cell.textLabel.text = venue.name;
	cell.detailTextLabel.text = venue.distance;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil] autorelease];
    }
	
	self.detailViewController.venue = [_venues objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

#pragma mark - Location Methods
- (void)getLocation
{
	if  (! [CLLocationManager locationServicesEnabled])
		return;
	
	[_clManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	for (Venue *venue in _venues) {
		[venue updateDistance:newLocation];
	}
	[_clManager stopUpdatingLocation];
	[self.tableView reloadData];
}
@end
