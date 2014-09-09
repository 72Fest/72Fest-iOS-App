//
//  PhotoTabBarViewController.m
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/9/14.
//
//

#import "PhotoTabBarViewController.h"

#define TAB_BAR_HEIGHT 49
#define TAB_BAR_WIDTH 320

#define TAB_BAR_UPLOAD_SELECTED_IMG @"btnCameraSelectedState.png"
#define TAB_BAR_GALLERY_SELECTED_IMG @"btnGallerySelectedState.png"

@interface PhotoTabBarViewController ()
@property (nonatomic, strong) UIImageView *tabBarImg;
@end

@implementation PhotoTabBarViewController

@synthesize tabBarImg = _tabBarImg;
@synthesize navController= _navController;

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

    //add upload view
    self.photoUploadController = [[PhotoUploadViewController alloc] init];
    
    //nav controller
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.photoUploadController];
    
    //gallery controller
    GalleryViewController *galleryVC = [[GalleryViewController alloc] initWithNibName:nil bundle:nil];
    
    //create gallery nav controller
    UINavigationController *galleryNavController = [[UINavigationController alloc] initWithRootViewController:galleryVC];
    //[[galleryNavController navigationBar] setTintColor:THEME_CLR];
    
    self.viewControllers = [NSArray arrayWithObjects:self.navController, galleryNavController, nil];
    [self.photoUploadController setParentTabBar:self.tabBarController.tabBar];
    
    //set up tab bar img
    self.delegate = self;
    
    CGRect tbFrame = CGRectMake(0, 0, TAB_BAR_WIDTH, TAB_BAR_HEIGHT);
    self.tabBarImg = [[UIImageView alloc] initWithFrame:tbFrame];
    
    [self.tabBar addSubview:self.tabBarImg];
    
    self.tabBarImg.image = [UIImage imageNamed:TAB_BAR_UPLOAD_SELECTED_IMG];

}

#pragma - mark Tab Bar delegate methods
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
