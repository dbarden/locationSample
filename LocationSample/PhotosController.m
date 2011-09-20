//
//  PhotosController.m
//  LocationSample
//
//  Created by Daniel Barden on 9/20/11.
//  Copyright (c) 2011 None. All rights reserved.
//

#import "PhotosController.h"

@implementation PhotosController

@synthesize venue = _venue;
@synthesize photoview = _photoview;

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

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    self.photoAlbumView.dataSource = self;
    self.photoScrubberView.dataSource = self;
//    self.hidesChromeWhenScrolling = NO;
//    self.showPhotoAlbumBeneathToolbar = NO;
    self.photoAlbumView.zoomingIsEnabled = NO;
    [self.photoAlbumView reloadData];

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{    
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

#pragma mark - Photo View Controller Data Source

- (UIImage *)photoAlbumScrollView:(NIPhotoAlbumScrollView *)photoAlbumScrollView photoAtIndex:(NSInteger)photoIndex photoSize:(NIPhotoScrollViewPhotoSize *)photoSize isLoading:(BOOL *)isLoading originalPhotoDimensions:(CGSize *)originalPhotoDimensions {
    NSString *imageName = [_venue.photos objectAtIndex:photoIndex];
    NSLog(@"Fetching image %@", imageName);    
    UIImage *image = [[UIImage imageNamed:imageName] retain];
    *photoSize = NIPhotoScrollViewPhotoSizeOriginal;
    return image;
}

- (NSInteger)numberOfPhotosInPhotoScrollView:(NIPhotoAlbumScrollView *)photoScrollView {
    NSLog(@"Number of photos %d", [_venue.photos count]);
    return [_venue.photos count];
}
@end
