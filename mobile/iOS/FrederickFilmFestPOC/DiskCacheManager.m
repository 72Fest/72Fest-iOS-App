//
//  DiskCacheManager.m
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 10/14/12.
//
//

#import "DiskCacheManager.h"

@interface DiskCacheManager()

- (id)initCache;
@property (nonatomic, strong) NSString *cachePath;

@end

@implementation DiskCacheManager
+  (DiskCacheManager *)defaultManager {
    static DiskCacheManager *_diskCacheManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _diskCacheManager = [[DiskCacheManager alloc] initCache];
    });

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
    if (![self existsInCache:fileName])
        [data writeToFile:[self.cachePath stringByAppendingPathComponent:fileName] atomically:NO];
}

- (NSData *)retrieveFromCache:(NSString *)fileName {
    NSError *error;

    NSData *data =
        [NSData dataWithContentsOfFile:[self.cachePath stringByAppendingPathComponent:fileName]
                               options:NSDataReadingUncached error:&error];
    
    return [NSData dataWithData:data];
}

@end
