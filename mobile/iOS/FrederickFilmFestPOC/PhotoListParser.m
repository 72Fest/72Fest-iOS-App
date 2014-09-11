//
//  PhotoListParser.m
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotoListParser.h"
#import "ConnectionInfo.h"

@interface PhotoListParser()

- (void)sortByOrder;

@property (nonatomic, strong) NSURL *url;

@end

@implementation PhotoListParser

@synthesize url = _url;
@synthesize photoList = _photoList;
@synthesize delegate = _delegate;



- (void)loadURL:(NSURL *)url {
    self.photoList = [[NSMutableArray alloc] init];
    
    //Use Grand Central Dispatcher to load off to a queue
    dispatch_queue_t photoLoaderQueue = dispatch_queue_create("Photo Loader Queue", NULL);
    
    dispatch_async(photoLoaderQueue, ^{
        
        NSData *data=[NSData dataWithContentsOfURL:url];
        
        if (!data) {
            NSLog(@"Failed to retrieve photo data!");
            return;
        }
        
        NSError *e = nil;

        NSArray *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
        
        if (!jsonDict) {
            NSLog(@"Error parsing JSON: %@", e);
        } else {
            if ([jsonDict valueForKey:API_MESSAGE_STATUS_KEY]) {
                NSLog(@"Failed to retieve photos!");
                
                NSDictionary *message = [jsonDict valueForKey:API_MESSAGE_KEY];
                NSDictionary *meta = [message valueForKey:@"metadata"];
                NSDictionary *photos = [message valueForKey:@"photos"];
                
                
                for(NSDictionary *item in photos) {
                   NSString *fullsrc = [NSString stringWithFormat: @"%@/%@",[meta valueForKey:@"baseUrl"],[item valueForKey:@"photoUrl"]];
                   NSString *thumbsrc = [NSString stringWithFormat: @"%@/%@",[meta valueForKey:@"baseUrl"],[item valueForKey:@"thumbUrl"]];
                   NSDictionary *photo = @{@"fullsrc": fullsrc, @"thumbsrc": thumbsrc};
                   
                    [self.photoList addObject:[NSDictionary dictionaryWithDictionary:photo]];
                }
            } else {
                //TODO: add an error message
            }
        }
        
        if ([self.delegate respondsToSelector:@selector(photoListParser:loadCompletedWithData:)]) {
            [self.delegate photoListParser:self loadCompletedWithData:self.photoList];
        }
    });

}

- (void)sortByOrder {
    //TODO:
}
@end
