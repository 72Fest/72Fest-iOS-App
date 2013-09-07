//
//  ImageCache.h
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageCache : NSObject

+ (ImageCache *)sharedImageCache;
- (void)setThumb:(UIImage *)thumbImg forKey:(NSString *)key;
- (UIImage *)thumbForKey:(NSString *)key;
- (void)purgeCache;
@end
