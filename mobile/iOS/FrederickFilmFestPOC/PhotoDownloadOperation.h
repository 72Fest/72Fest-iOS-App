//
//  PhotoDownloadOperation.h
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/17/13.
//
//

#import <Foundation/Foundation.h>
#import "PhotoDownloadOperationDelegate.h"

@interface PhotoDownloadOperation : NSOperation
- (id)initWithURL:(NSURL *)url andImageKey:(NSString *)imageKey andImageIndex:(NSInteger)imageIndex andDelegate:(id<PhotoDownloadOperationDelegate>)delegate;

@property (nonatomic, strong) NSString *imageKey;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, assign) NSInteger imageIndex;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, weak) id<PhotoDownloadOperationDelegate> delegate;
@end
