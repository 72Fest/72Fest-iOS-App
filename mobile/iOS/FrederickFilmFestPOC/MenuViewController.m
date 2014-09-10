//
//  MenuViewController.m
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/8/14.
//
//

#import "MenuViewController.h"
#import "InfoViewController.h"
#import "PhotoTabBarViewController.h"
#import "TeamsViewController.h"
#import "TWTSideMenuViewController.h"

@interface MenuViewController ()
@property (nonatomic, assign) MainMenuItem curMenuItem;
@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.curMenuItem = MENU_ITEM_PHOTOS;
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
    
    if (self.curMenuItem != MENU_ITEM_PHOTOS) {
        PhotoTabBarViewController *controller = [[PhotoTabBarViewController alloc] initWithNibName:nil bundle:nil];
        
        self.curMenuItem = MENU_ITEM_PHOTOS;
        [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
    } else {
        [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
    }
}

- (IBAction)infoBtnPressed:(id)sender {
    
    if (self.curMenuItem != MENU_ITEM_INFO) {
        InfoViewController *infoViewController = [[InfoViewController alloc] initWithNibName:nil bundle:nil];
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:infoViewController];
     
        self.curMenuItem = MENU_ITEM_INFO;
        [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
    } else {
        [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
    }
}
- (IBAction)teamsBtnPressed:(id)sender {
    
    if (self.curMenuItem != MENU_ITEM_TEAMS) {
        TeamsViewController *teamsViewController =
            [[TeamsViewController alloc] initWithNibName:nil bundle:nil];
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:teamsViewController];
        
        self.curMenuItem = MENU_ITEM_TEAMS;
        [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
    } else {
        [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
    }
}

@end
