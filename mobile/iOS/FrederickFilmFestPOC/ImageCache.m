//
//  ImageCache.m
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageCache.h"

static ImageCache *_sharedImageCache;

@interface ImageCache() 
@property (nonatomic, strong) NSMutableDictionary *hashTable;
@end

@implementation ImageCache

@synthesize hashTable = _hashTable;

- (id)init {
    self = [super init];
    if (self) {
        self.hashTable = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}


+ (ImageCache *)sharedImageCache {
    if (!_sharedImageCache) {
        _sharedImageCache = [[ImageCache alloc] init];
    }
    return _sharedImageCache;
}

- (void)setThumb:(UIImage *)thumbImg forKey:(NSString *)key {
    
    if (![self.hashTable valueForKey:key]){
        [self.hashTable setValue:[thumbImg copy] forKey:key];
    }
}

- (UIImage *)thumbForKey:(NSString *)key {
    return [(UIImage *)[self.hashTable valueForKey:key] copy];
}

- (void)purgeCache {
    [self.hashTable removeAllObjects];
}
@end
