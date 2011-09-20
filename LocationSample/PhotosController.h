//
//  PhotosController.h
//  LocationSample
//
//  Created by Daniel Barden on 9/20/11.
//  Copyright (c) 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NimbusPhotos.h"
#import "Venue.h"

@interface PhotosController : NIToolbarPhotoViewController <NIPhotoAlbumScrollViewDataSource, NIPhotoScrubberViewDataSource>

@property (nonatomic, retain) Venue *venue;
@property (nonatomic, retain) NIPhotoAlbumScrollView *photoview;
@end
