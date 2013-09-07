//
//  DiskCacheManager.h
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 10/14/12.
//
//

#import <Foundation/Foundation.h>

@interface DiskCacheManager : NSObject
+ (DiskCacheManager *)defaultManager;

- (BOOL)existsInCache:(NSString *)fileName;
- (void)saveToCache:(NSData *)data withFilename:(NSString *)fileName;
- (NSData *)retrieveFromCache:(NSString *)fileName;
@end
