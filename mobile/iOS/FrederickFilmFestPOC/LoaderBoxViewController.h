//
//  LoaderBoxViewController.h
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 7/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoaderBoxViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (weak, nonatomic) IBOutlet UILabel *loadingCaption;
- (void)setLoading:(BOOL)isLoading;

- (void)setCaptionText: (NSString *)str;
@end
