//
//  PhotoDownloadOperation.m
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/17/13.
//
//

#import "PhotoDownloadOperation.h"
#import "DiskCacheManager.h"

@implementation PhotoDownloadOperation
- (id)initWithURL:(NSURL *)url andImageKey:(NSString *)imageKey andImageIndex:(NSInteger)imageIndex andDelegate:(id<PhotoDownloadOperationDelegate>)delegate {
    
    self = [super init];
    if (self) {
        self.imageURL = url;
        self.imageKey = imageKey;
        self.imageIndex = imageIndex;
        self.delegate = delegate;
    }
    
    return self;
}

- (void)main {
    @autoreleasepool {
        NSData *imgData = nil;
        
        if (self.isCancelled) return;
        
        if ([[DiskCacheManager defaultManager] existsInCache:self.imageKey]) {
            //we found it in the disk cache, lets save the pull from the
            //network and grab it from the disk cache
            if (self.isCancelled) return;
            
            imgData = [[DiskCacheManager defaultManager] retrieveFromCache:self.imageKey];
        } else {
            if (self.isCancelled) return;
            
            //pull it from the network, but then save to the cache
            imgData = [NSData dataWithContentsOfURL:self.imageURL];

            if (self.isCancelled) return;
            
            NSLog(@"ULR:%@", self.imageURL);
            if (imgData) {
                [[DiskCacheManager defaultManager] saveToCache:imgData withFilename:self.imageKey];
            }
            
        }
        
        if (self.isCancelled) return;
        
        if (imgData) {
            //save image and notify delegate
            self.image = [UIImage imageWithData:imgData];
            [(NSObject *)self.delegate performSelectorOnMainThread:@selector(photoDownloadOperationComplete:) withObject:self waitUntilDone:NO];
        }
        
    }
}

@end
