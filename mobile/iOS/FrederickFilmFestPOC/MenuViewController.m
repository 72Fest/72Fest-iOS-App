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
#import "ContactViewController.h"
#import "NewsViewController.h"
#import "TWTSideMenuViewController.h"
#import "CountDownView.h"
#import "ConnectionInfo.h"

#define BUTTON_FONT [UIFont fontWithName:LABEL_FONT_NAME size:16]

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
    // Assign custom font
    [self.photosBtn.titleLabel setFont:BUTTON_FONT];
    [self.teamsBtn.titleLabel setFont:BUTTON_FONT];
    [self.infoBtn.titleLabel setFont:BUTTON_FONT];
    [self.contactBtn.titleLabel setFont:BUTTON_FONT];
    [self.newsBtn.titleLabel setFont:BUTTON_FONT];
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

- (IBAction)contactBtnPressed:(id)sender {
    if (self.curMenuItem != MENU_ITEM_CONTACT) {
        ContactViewController *contactViewController =
            [[ContactViewController alloc] initWithURL:[NSURL URLWithString:CONTACT_URL_STR] andLoadingCaption:@"Loading contact form ..."];
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:contactViewController];
        
        self.curMenuItem = MENU_ITEM_CONTACT;
        [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
    } else {
        [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
    }
}

- (IBAction)newsBtnPressed:(id)sender {
    if (self.curMenuItem != NEMU_ITEM_NEWS) {
        NewsViewController *newsViewController =
        [[NewsViewController alloc] initWithURL:[NSURL URLWithString:NEWS_URL_STR] andLoadingCaption:@"Loading news feed ..."];
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:newsViewController];
        
        self.curMenuItem = NEMU_ITEM_NEWS;
        [self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];
    } else {
        [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
    }
}

@end
