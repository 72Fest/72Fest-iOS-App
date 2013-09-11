//
//  PhotoDetailViewController.h
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NIToolbarPhotoViewController.h"
#define VOTE_UP_ICON_IMG [UIImage imageNamed:@"voteUpIcon.png"]
#define VOTE_DOWN_ICON_IMG [UIImage imageNamed:@"voteDownIcon.png"]

#define VOTE_RESULT_STATUS_KEY @"status"
#define VOTE_REULST_TOTALS_KEY @"votes"

@interface PhotoDetailViewController : NIToolbarPhotoViewController <NIPhotoAlbumScrollViewDataSource, NIPagingScrollViewDelegate, NSURLConnectionDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSArray *photosList;
@property (nonatomic, assign) NSInteger selectedPhotIndex;

@end
