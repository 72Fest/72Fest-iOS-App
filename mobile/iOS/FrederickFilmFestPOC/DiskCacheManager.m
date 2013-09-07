//
//  DiskCacheManager.m
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 10/14/12.
//
//

#import "DiskCacheManager.h"

static DiskCacheManager *_diskCacheManager;
@interface DiskCacheManager() {
    NSString *cachePath;
    NSString *curPath;
}

@end
@implementation DiskCacheManager
+  (DiskCacheManager *)defaultManager {
    if (_diskCacheManager == nil) {
        _diskCacheManager = [[DiskCacheManager alloc] init];
    }
    
    return _diskCacheManager;
}

- (id)init {
    self = [super init];
    
    if (self) {
        NSArray* cachePathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        cachePath = [cachePathArray objectAtIndex:0];
        [cachePath retain];
    }
    
    return self;
}

- (void)dealloc {
    [cachePath release];
    [_diskCacheManager release];
    [super dealloc];
}


- (BOOL)existsInCache:(NSString *)fileName {
    return [[NSFileManager defaultManager] fileExistsAtPath:[cachePath stringByAppendingPathComponent:fileName]];
}

- (void)saveToCache:(NSData *)data withFilename:(NSString *)fileName {
    curPath = [cachePath stringByAppendingPathComponent:fileName];
    
    [data writeToFile:[cachePath stringByAppendingPathComponent:fileName] atomically:YES];
}

- (NSData *)retrieveFromCache:(NSString *)fileName {
    NSData *data = [NSData dataWithContentsOfFile:[cachePath stringByAppendingPathComponent:fileName]];
    
    return data;
}

@end
