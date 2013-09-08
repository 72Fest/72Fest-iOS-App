//
//  DiskCacheManager.m
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 10/14/12.
//
//

#import "DiskCacheManager.h"

static DiskCacheManager *_diskCacheManager;
@interface DiskCacheManager()

- (id)initCache;
@property (nonatomic, strong) NSString *cachePath;

@end

@implementation DiskCacheManager
+  (DiskCacheManager *)defaultManager {
    if (_diskCacheManager == nil) {
        _diskCacheManager = [[DiskCacheManager alloc] initCache];
    }
    
    return _diskCacheManager;
}

- (id)initCache {
    self = [super init];
    
    if (self) {
        NSArray* cachePathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        self.cachePath = [cachePathArray objectAtIndex:0];
    }
    
    return self;
}



- (BOOL)existsInCache:(NSString *)fileName {
    return [[NSFileManager defaultManager] fileExistsAtPath:[self.cachePath stringByAppendingPathComponent:fileName]];
}

- (void)saveToCache:(NSData *)data withFilename:(NSString *)fileName {
    [data writeToFile:[self.cachePath stringByAppendingPathComponent:fileName] atomically:YES];
}

- (NSData *)retrieveFromCache:(NSString *)fileName {
    NSData *data = [NSData dataWithContentsOfFile:[self.cachePath stringByAppendingPathComponent:fileName]];
    
    return [data copy];
}

@end
