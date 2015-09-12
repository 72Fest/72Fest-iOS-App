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

#define THEME_CLR [UIColor colorWithRed:102.0/255.0 green:142.0/255.0 blue:91.0/255.0 alpha:1.0]
#define THEME_BG_CLR [UIColor colorWithRed:96.0/255.0 green:103.0/255.0 blue:144.0/255.0 alpha:1.0]

@interface FrederickFilmFestPOCAppDelegate : NSObject <UIApplicationDelegate> {
    
}

@property (nonatomic, strong) IBOutlet UIWindow *window;

@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) MenuViewController *menuViewController;
@property (nonatomic, strong) TWTSideMenuViewController *sideMenuController;
@end
