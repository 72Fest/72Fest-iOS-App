//
//  ImageCache.m
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageCache.h"


@interface ImageCache()
@property (nonatomic, assign) dispatch_queue_t thumbCacheQueue;
@property (nonatomic, strong) NSMutableDictionary *hashTable;
@end

@implementation ImageCache

@synthesize hashTable = _hashTable;

- (id)init {
    self = [super init];
    if (self) {
        self.hashTable = [[NSMutableDictionary alloc] init];
        //self.thumbCacheQueue = dispatch_queue_create("Thumb Cache Queue", DISPATCH_QUEUE_SERIAL);
    }
    
    return self;
}


+ (ImageCache *)sharedImageCache {
    static ImageCache *_sharedImageCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedImageCache = [[ImageCache alloc] init];
    });
    
    return _sharedImageCache;
}

- (void)setThumb:(UIImage *)thumbImg forKey:(NSString *)key {
    
    dispatch_async(dispatch_queue_create("Thumb Cache Queue", DISPATCH_QUEUE_SERIAL), ^{
        if (![self.hashTable objectForKey:key]){
            [self.hashTable setObject:[thumbImg copy] forKey:key];
        }
    });
}

- (UIImage *)thumbForKey:(NSString *)key {
    return [(UIImage *)[self.hashTable objectForKey:key] copy];
}

- (void)purgeCache {
    [self.hashTable removeAllObjects];
}
@end
