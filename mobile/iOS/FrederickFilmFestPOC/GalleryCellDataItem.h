//
//  GalleryCellDataItem.h
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryCellDataItem : UIButton

- (void)setThumb:(UIImage *)img;

@property (nonatomic, strong) NSIndexPath *itemIndexPath;
@property (nonatomic, strong) NSURL *fullImageURL;

@end
