//
//  GalleryTableViewCell.h
//  ILoveHem
//
//  Created by Lonny Gomes on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryCellDataItem.h"

@interface GalleryTableViewCell : UITableViewCell

- (NSArray *)dataItems;
- (void)clearItems;

@property (nonatomic, retain) IBOutlet GalleryCellDataItem *dataItem0;
@property (nonatomic, retain) IBOutlet GalleryCellDataItem *dataItem1;
@property (nonatomic, retain) IBOutlet GalleryCellDataItem *dataItem2;
@property (nonatomic, retain) IBOutlet GalleryCellDataItem *dataItem3;
@end
