//
//  GenericWebContentViewController.m
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/11/14.
//
//

#import "GenericWebContentViewController.h"
#import "TWTSideMenuViewController.h"
#import "LoaderBoxViewController.h"

@interface GenericWebContentViewController ()
@property (nonatomic, strong) NSURL *contentURL;
@property (nonatomic, strong) LoaderBoxViewController *loaderBoxVC;
@end

@implementation GenericWebContentViewController

- (id)initWithURL:(NSURL *)url andLoadingCaption:(NSString *)captionStr {
    self = [self initWithNibName:nil bundle:nil];
    
    if (self) {
        self.contentURL = url;
        self.loadingCaptionStr = captionStr;
    }
    
    return self;
}

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
    [self.loaderBoxVC setCaptionText:self.loadingCaptionStr];
    [self.loaderBoxVC setLoading:YES];
    
    CGRect curFrame = self.view.frame;
    CGRect loaderFrame = self.loaderBoxVC.view.frame;
    //center the loader box
    loaderFrame.origin.x = (curFrame.size.width/2) - (loaderFrame.size.width/2);
    loaderFrame.origin.y = (curFrame.size.height/2) - (loaderFrame.size.height);
    self.loaderBoxVC.view.frame = loaderFrame;
    
    NSURLRequest *req = [NSURLRequest requestWithURL:self.contentURL];
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
