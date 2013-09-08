//
//  GalleryViewController.h
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoListParser.h"
#import "PhotoListParserProtocol.h"
#import "ConnectionInfo.h"

#define GALLERY_CELL_CLASS_NAME @"GalleryTableViewCell"
#define GALLERY_TABLE_CELL_HEIGHT 80.0
#define THUMBS_PER_ROW 4

@class GalleryTableViewCell;
@class GalleryCellDataItem;

@interface GalleryViewController : UIViewController <UITableViewDataSource,  PhotoListParserProtocol>

- (void)refreshGalleryData;

//Targe actions
- (void)galleryThumbPressed:(GalleryCellDataItem *)sender;
- (void)photoDetailCloseBtnPressed:(id)sender;
- (void)refreshPressed:(id)sender;

// table methods
- (GalleryTableViewCell *)retrieveGalleryCellForTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath andDequeueName:(NSString *)dequeueName;

@property (nonatomic, strong) PhotoListParser *photoListParser;
@property (nonatomic, strong) NSArray *imageNames;
@property (strong, nonatomic) IBOutlet UITableView *galleryTableView;
@property (nonatomic, assign) BOOL isRefreshing;
@end
