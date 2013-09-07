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
@property (nonatomic, retain) NSMutableDictionary *hashTable;
@end

@implementation ImageCache

@synthesize hashTable = _hashTable;

- (id)init {
    self = [super init];
    if (self) {
        self.hashTable = [[[NSMutableDictionary alloc] init] autorelease];
    }
    
    return self;
}

- (void)dealloc {
    [_hashTable release];
    [super dealloc];
}

+ (ImageCache *)sharedImageCache {
    if (!_sharedImageCache) {
        _sharedImageCache = [[ImageCache alloc] init];
    }
    return _sharedImageCache;
}

- (void)setThumb:(UIImage *)thumbImg forKey:(NSString *)key {
    
    if (![self.hashTable valueForKey:key]){
        [self.hashTable setValue:thumbImg forKey:key];
    }
}

- (UIImage *)thumbForKey:(NSString *)key {
    return (UIImage *)[self.hashTable valueForKey:key];
}

- (void)purgeCache {
    [self.hashTable removeAllObjects];
}
@end
