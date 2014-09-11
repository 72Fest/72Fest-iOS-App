//
//  ContactViewController.m
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/11/14.
//
//

#import "ContactViewController.h"
#import "TWTSideMenuViewController.h"
#import "LoaderBoxViewController.h"

#define CONTACT_URL @"http://www.72fest.com/about/contact/"

@interface ContactViewController ()
@property (nonatomic, strong) LoaderBoxViewController *loaderBoxVC;
@end

@implementation ContactViewController

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
    UIImageView *iv =
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"filmFestLogo.png"]];
    [[self navigationItem] setTitleView:iv];
    
    UIBarButtonItem *menuBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"hamburgerIcon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btnPressed:)];
    self.navigationItem.leftBarButtonItem = menuBtn;
    
    //setup loader box
    self.loaderBoxVC = [[LoaderBoxViewController alloc] init];
    [self.view addSubview:self.loaderBoxVC.view];
    [self.loaderBoxVC setCaptionText:@"Loading Contact Form ..."];
    [self.loaderBoxVC setLoading:YES];
    
    CGRect curFrame = self.view.frame;
    CGRect loaderFrame = self.loaderBoxVC.view.frame;
    //center the loader box
    loaderFrame.origin.x = (curFrame.size.width/2) - (loaderFrame.size.width/2);
    loaderFrame.origin.y = (curFrame.size.height/2) - (loaderFrame.size.height);
    self.loaderBoxVC.view.frame = loaderFrame;
    
    NSURL *url = [NSURL URLWithString:CONTACT_URL];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];
}

#pragma mark - Web View delegates
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.loaderBoxVC setLoading:NO];
}

#pragma mark - IB actions
- (void)btnPressed:(id)sender {
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
