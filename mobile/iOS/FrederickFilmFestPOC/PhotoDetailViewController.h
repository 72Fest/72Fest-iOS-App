//
//  PhotoDetailViewController.h
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NIToolbarPhotoViewController.h"
#import "VotingOperationDelegate.h"
#import <MessageUI/MessageUI.h>

#define VOTE_UP_ICON_IMG [UIImage imageNamed:@"voteUpIcon.png"]
#define VOTE_DOWN_ICON_IMG [UIImage imageNamed:@"voteDownIcon.png"]

#define VOTE_RESULT_STATUS_KEY @"status"
#define VOTE_REULST_TOTALS_KEY @"votes"

#define PHOTO_EMAIL_SUBJECT_TEXT @"72Fest Photo"
#define PHOTO_EMAIL_BODY_TEXT @"Checkout this photo shared with 72 Fest app!"

typedef enum {
    SHARE_ITEM_TWITTER,
    SHARE_ITEM_FACEBOOK,
    SHARE_ITEM_CAMERA_ROLL,
    Share_ITEM_EMAIL,
    SHARE_ITEM_NONE
} ShareItem;

@interface PhotoDetailViewController : NIToolbarPhotoViewController <NIPhotoAlbumScrollViewDataSource, NIPagingScrollViewDelegate, NSURLConnectionDelegate, VotingOperationDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) NSArray *photosList;
@property (nonatomic, assign) NSInteger selectedPhotIndex;

@end
