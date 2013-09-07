//
//  LoaderBoxViewController.h
//  FrederickFilmFestPOC
//
//  Created by Lonny Gomes on 7/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoaderBoxViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (void)setLoading:(BOOL)isLoading;
@end
