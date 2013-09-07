//
//  GalleryTableViewCell.m
//  ILoveHem
//
//  Created by Lonny Gomes on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GalleryTableViewCell.h"

@implementation GalleryTableViewCell

@synthesize dataItem0=_dataItem0, dataItem1=_dataItem1, dataItem2=_dataItem2, dataItem3=_dataItem3;


- (NSArray *)dataItems {
    return [NSArray arrayWithObjects:_dataItem0, _dataItem1, _dataItem2, _dataItem3, nil];
}

- (void)clearItems {
    [self.dataItem0 setThumb:nil];
    [self.dataItem1 setThumb:nil];
    [self.dataItem2 setThumb:nil];
    [self.dataItem3 setThumb:nil];
}

#pragma mark - View lifecycle


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
