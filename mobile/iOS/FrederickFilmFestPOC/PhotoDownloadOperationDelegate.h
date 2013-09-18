//
//  PhotoDownloadOperationDelegate.h
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/17/13.
//
//

#import <Foundation/Foundation.h>
@class PhotoDownloadOperation;

@protocol PhotoDownloadOperationDelegate <NSObject>
@required
- (void)photoDownloadOperationComplete:(PhotoDownloadOperation *)photoOperation;
@end
