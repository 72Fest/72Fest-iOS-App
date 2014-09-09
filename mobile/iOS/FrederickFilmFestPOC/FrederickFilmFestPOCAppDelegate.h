//
//  FrederickFilmFestPOCAppDelegate.h
//  FrederickFilmFestPOC
//
//  Created by Mass Defect on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"
#import "TWTSideMenuViewController.h"

#define THEME_CLR [UIColor colorWithRed:239.0/255.0 green:57.0/255.0 blue:60.0/255.0 alpha:1.0]
#define THEME_BG_CLR [UIColor colorWithRed:66.0/255.0 green:146.0/255.0 blue:158.0/255.0 alpha:1.0]

@interface FrederickFilmFestPOCAppDelegate : NSObject <UIApplicationDelegate> {
    
}

@property (nonatomic, strong) IBOutlet UIWindow *window;

@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) MenuViewController *menuViewController;
@property (nonatomic, strong) TWTSideMenuViewController *sideMenuController;
@end
