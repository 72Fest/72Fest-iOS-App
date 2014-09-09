//
//  PhotoTabBarViewController.h
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/9/14.
//
//

#import <UIKit/UIKit.h>
#import "PhotoUploadViewController.h"
#import "GalleryViewController.h"
#import "TWTSideMenuViewController.h"

@interface PhotoTabBarViewController : UITabBarController <UITabBarControllerDelegate>

@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic, strong) PhotoUploadViewController *photoUploadController;
@end
