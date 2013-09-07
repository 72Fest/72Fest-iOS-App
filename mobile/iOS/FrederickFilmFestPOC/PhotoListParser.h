//
//  PhotoListParser.h
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoListParserProtocol.h"


#define XML_TAG_ENTRIES @"entries"
#define XML_TAG_IMAGE @"image"
#define XML_TAG_ID @"id"
#define XML_TAG_FULL_URL @"fullsrc"
#define XML_TAG_THUMB_URL @"thumbsrc"
#define XML_TAG_EVENT @"event"
#define XML_TAG_APPROVED @"approved"

@interface PhotoListParser : NSObject {
    NSMutableArray *appData;
}

- (void)loadURL:(NSURL *)url;


@property (nonatomic, retain) NSMutableArray *photoList;
@property (nonatomic, assign) id delegate;

@end
