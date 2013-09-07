//
//  FrederickFilmFestPOCAppDelegate.h
//  FrederickFilmFestPOC
//
//  Created by Mass Defect on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoUploadViewController.h"

#define THEME_CLR [UIColor colorWithRed:0/255.0 green:95.0/255.0 blue:157.0/255.0 alpha:1.0]

@interface FrederickFilmFestPOCAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) PhotoUploadViewController *photoUploadController;

@end
