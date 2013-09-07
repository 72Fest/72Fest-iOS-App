//
//  PhotoListParserProtocol.h
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PhotoListParser;

@protocol PhotoListParserProtocol <NSObject>

- (void)photoListParser: (PhotoListParser *)photoListParser loadCompletedWithData:(NSArray *)photoListData;
@end
