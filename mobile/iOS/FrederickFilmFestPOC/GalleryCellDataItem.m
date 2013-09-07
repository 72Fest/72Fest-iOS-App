//
//  GalleryCellDataItem.m
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GalleryCellDataItem.h"

@implementation GalleryCellDataItem
@synthesize itemIndexPath=_itemIndexPath;
@synthesize fullImageURL=_fullImageURL;

- (void)dealloc {
    [_itemIndexPath release];
    [_fullImageURL release];
    [super dealloc];
}

- (void)setThumb:(UIImage *)img; {
    if (!img) {
        //NSLog(@"Clearing thumb!");
        //self.fullImageURL = nil;
        //self.itemIndexPath = nil;
    }
    
    //set the background image
    [self setBackgroundImage:img forState:UIControlStateNormal];
}

@end
