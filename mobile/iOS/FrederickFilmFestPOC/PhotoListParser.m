//
//  PhotoListParser.m
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotoListParser.h"

@interface PhotoListParser()

- (void)sortByOrder;

@property (nonatomic, retain) NSURL *url;

@end

@implementation PhotoListParser

@synthesize url = _url;
@synthesize photoList = _photoList;
@synthesize delegate = _delegate;


- (void) dealloc {
    [_url release];
    [_photoList release];
    [super dealloc];
}

- (void)loadURL:(NSURL *)url {
    self.photoList = [[[NSMutableArray alloc] init] autorelease];
    
    //Use Grand Central Dispatcher to load off to a queue
    dispatch_queue_t photoLoaderQueue = dispatch_queue_create("Photo Loader Queue", NULL);
    
    dispatch_async(photoLoaderQueue, ^{
        
        NSData *data=[NSData dataWithContentsOfURL:url];
        NSError *e = nil;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
        
        if (!jsonArray) {
            NSLog(@"Error parsing JSON: %@", e);
        } else {
            NSDictionary *meta = [jsonArray valueForKey:@"Meta"];
            NSDictionary *photos = [jsonArray valueForKey:@"Photos"];
            
            
           for(NSDictionary *item in photos) {
               NSString *fullsrc = [NSString stringWithFormat: @"%@/%@%@",[meta valueForKey:@"url"],[item valueForKey:@"id"],[meta valueForKey:@"extension"]];
               NSString *thumbsrc = [NSString stringWithFormat: @"%@/%@%@%@",[meta valueForKey:@"url"],[item valueForKey:@"id"],[meta valueForKey:@"thumb"],[meta valueForKey:@"extension"]];
               NSDictionary *photo = @{@"fullsrc": fullsrc, @"thumbsrc": thumbsrc};
               
                [self.photoList addObject:[NSDictionary dictionaryWithDictionary:photo]];
            }
        }
        
        if ([self.delegate respondsToSelector:@selector(photoListParser:loadCompletedWithData:)]) {
            [self.delegate photoListParser:self loadCompletedWithData:self.photoList];
        }
    });

    dispatch_release(photoLoaderQueue);
}

- (void)sortByOrder {
    //TODO:
}
@end
