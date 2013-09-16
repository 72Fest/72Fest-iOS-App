//
//  FrederickFilmFestPOCAppDelegate.m
//  FrederickFilmFestPOC
//
//  Created by Mass Defect on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FrederickFilmFestPOCAppDelegate.h"
#import "PhotoUploadViewController.h"
#import "GalleryViewController.h"
#import "UIImage+Color.h"

#define TAB_BAR_UPLOAD_SELECTED_IMG @"btnCameraSelectedState.png"
#define TAB_BAR_GALLERY_SELECTED_IMG @"btnGallerySelectedState.png"

#define TAB_BAR_HEIGHT 49
#define TAB_BAR_WIDTH 320

@interface FrederickFilmFestPOCAppDelegate()

-(void)initTabBar;

@property (nonatomic, strong) UIImageView *tabBarImg;
@end
@implementation FrederickFilmFestPOCAppDelegate


@synthesize window=_window;
@synthesize navController=_navController;
@synthesize tabBarController=_tabBarController;
@synthesize tabBarImg = _tabBarImg;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //add upload view
    self.photoUploadController = [[PhotoUploadViewController alloc] init];
    
    //nav controller
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.photoUploadController];
        
    //set up tab bar item
//    UITabBarItem *tbi = [[UITabBarItem alloc] initWithTitle:@"Upload" image:[UIImage imageNamed:@"upload-photo.png"] tag:1];
//    
//    self.navController.tabBarItem = tbi;
//    [tbi release];
    
    //set tint for nav controller
    [[self.navController navigationBar] setTintColor:THEME_CLR];
    [[self.navController navigationBar] setBackgroundImage:[UIImage imageWithColor:THEME_CLR] forBarMetrics:UIBarMetricsDefault];
    
    //gallery controller
    GalleryViewController *galleryVC = [[GalleryViewController alloc] initWithNibName:nil bundle:nil];
    
    //create gallery nav controller
    UINavigationController *galleryNavController = [[UINavigationController alloc] initWithRootViewController:galleryVC];
    [[galleryNavController navigationBar] setTintColor:THEME_CLR];
    
    //creating tab view
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:self.navController, galleryNavController, nil];
    
    
    [self.photoUploadController setParentTabBar:self.tabBarController.tabBar];
    
    self.window.rootViewController = self.tabBarController;
    //[[self window] addSubview:[self.navController view]];
    
    [self initTabBar];
    
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)initTabBar {
    //if we are in iOS 5, we can tint
    if ([[UITabBar class] respondsToSelector:@selector(appearance)]) {
        [[UITabBar appearance] setTintColor:THEME_CLR];
        [[UITabBar appearance] setSelectedImageTintColor:[UIColor lightGrayColor]];
    }
    
    //set up tab bar img
    self.tabBarController.delegate = self;
    
    CGRect tbFrame = CGRectMake(0, 0, TAB_BAR_WIDTH, TAB_BAR_HEIGHT);
    self.tabBarImg = [[UIImageView alloc] initWithFrame:tbFrame];
    
    [self.tabBarController.tabBar addSubview:self.tabBarImg];
    
    self.tabBarImg.image = [UIImage imageNamed:TAB_BAR_UPLOAD_SELECTED_IMG];
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    NSUInteger index=[[tabBarController viewControllers] indexOfObject:viewController];
    switch (index) {
        case 0:
            self.tabBarImg.image = [UIImage imageNamed:TAB_BAR_UPLOAD_SELECTED_IMG];
            break;
        case 1:
            self.tabBarImg.image = [UIImage imageNamed:TAB_BAR_GALLERY_SELECTED_IMG];
            break;
    }
    
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
