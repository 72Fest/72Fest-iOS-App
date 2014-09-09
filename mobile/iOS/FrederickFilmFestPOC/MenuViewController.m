//
//  MenuViewController.m
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/8/14.
//
//

#import "MenuViewController.h"
#import "InfoViewController.h"
#import "FrederickFilmFestPOCAppDelegate.h"
#import "TWTSideMenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)photosBtnPressed:(id)sender {
//    [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
//    PhotoUploadViewController *photoUploadController = [[PhotoUploadViewController alloc] initWithNibName:nil bundle:nil];
//
//    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:photoUploadController];
//    
//    [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
    
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[(FrederickFilmFestPOCAppDelegate *)[[UIApplication sharedApplication] delegate] genTabBar]];
    
    [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
}

- (IBAction)infoBtnPressed:(id)sender {
    InfoViewController *infoViewController = [[InfoViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:infoViewController];
    
    [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
}

@end
