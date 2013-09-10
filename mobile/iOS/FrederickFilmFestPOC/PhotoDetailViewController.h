//
//  PhotoDetailViewController.h
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NIToolbarPhotoViewController.h"

@interface PhotoDetailViewController : NIToolbarPhotoViewController <NIPhotoAlbumScrollViewDataSource, NIPagingScrollViewDelegate>

@property (nonatomic, strong) NSArray *photosList;
@property (nonatomic, assign) NSInteger selectedPhotIndex;

@end
