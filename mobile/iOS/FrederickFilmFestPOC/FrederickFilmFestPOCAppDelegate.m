//
//  FrederickFilmFestPOCAppDelegate.m
//  FrederickFilmFestPOC
//
//  Created by Mass Defect on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FrederickFilmFestPOCAppDelegate.h"
#import "PhotoUploadViewController.h"
#import "PhotoTabBarViewController.h"
#import "GalleryViewController.h"
#import "UIImage+Color.h"
#import "IOSCompatability.h"

@interface FrederickFilmFestPOCAppDelegate()

@end
@implementation FrederickFilmFestPOCAppDelegate


@synthesize window=_window;
@synthesize tabBarController=_tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    //set tint for nav controller
    [[[UINavigationBar class] appearance] setTintColor:[UIColor whiteColor]];
    [[[UINavigationBar class] appearance] setBarTintColor:THEME_CLR];
    
    //tint the tab bar as well
    [[UITabBar appearance] setTintColor:THEME_CLR];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor lightGrayColor]];
    
    //create menu
    self.menuViewController = [[MenuViewController alloc] initWithNibName:nil bundle:nil];
    
    //creating tab view
    self.tabBarController = [[PhotoTabBarViewController alloc] initWithNibName:nil bundle:nil];
    
    //create side menu that will control the content
    self.sideMenuController = [[TWTSideMenuViewController alloc] initWithMenuViewController:self.menuViewController mainViewController:self.tabBarController];
    
    // specify the shadow color to use behind the main view controller when it is scaled down.
    self.sideMenuController.shadowColor = [UIColor blackColor];
    
    // specify a UIOffset to offset the open position of the menu
    self.sideMenuController.edgeOffset = UIOffsetMake(18.0f, 0.0f);
    
    // specify a scale to zoom the interface — the scale is 0.0 (scaled to 0% of it's size) to 1.0 (not scaled at all). The example here specifies that it zooms so that the main view is 56.34% of it's size in open mode.
    self.sideMenuController.zoomScale = 0.5634f;

    self.window.rootViewController = self.sideMenuController;
    
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
