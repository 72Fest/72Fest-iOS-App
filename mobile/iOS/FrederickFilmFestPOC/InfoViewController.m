//
//  InfoViewController.m
//  FrederickFilmFestPOC
//
//  Created by Mass Defect on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InfoViewController.h"
#import "ConnectionInfo.h"
#import "FrederickFilmFestPOCAppDelegate.h"
#import "IOSCompatability.h"
#import "TWTSideMenuViewController.h"


@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIImageView *iv =
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"filmFestLogo.png"]];
    [[self navigationItem] setTitleView:iv];
    

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = THEME_CLR;

    //set background
    CGRect frame = self.view.frame;
    UIView *v = [[UIView alloc] initWithFrame:frame];
    UIImage *i = [UIImage imageNamed:@"bkg.png"];
    UIColor *c = [[UIColor alloc] initWithPatternImage:i];
    v.backgroundColor = c;
    [[self view] insertSubview:v atIndex:0];
    
    UIBarButtonItem *menuBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"hamburgerIcon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btnPressed:)];
    self.navigationItem.leftBarButtonItem = menuBtn;
    
    //make content bg transparent and add to scroll pane
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    [self.scrollView addSubview:self.contentView];
    
    self.scrollView.contentSize = self.contentView.frame.size;
}

- (void)viewDidUnload
{
    [self setSiteBannerBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    dismissBtn = nil;
    
    urlLabel = nil;
    
    designUrlLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - touch methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//See if touch was inside the label
	if (CGRectContainsPoint(urlLabel.frame, [[[event allTouches] anyObject] locationInView:[self view]]))
	{
		//Open webpage
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:EMAIL_URL_STR]];
	} else if (CGRectContainsPoint(designUrlLabel.frame, [[[event allTouches] anyObject] locationInView:[self view]])) {
        //Open webpage
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:DESIGN_URL_STR]];
    }
}

- (IBAction)bannerPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:MAIN_URL_STR]];
}

- (void)btnPressed:(id)sender {
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

#pragma mark - IB Actions
- (IBAction)artistBtnPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:DESIGN_URL_STR]];
}

- (IBAction)sponsor1BtnPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SPONSOR_1_URL_STR]];
}

- (IBAction)sponsor2BtnPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SPONSOR_2_URL_STR]];
}

- (IBAction)sponsor3BtnPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SPONSOR_3_URL_STR]];
}


- (IBAction)sponsor4BtnPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SPONSOR_4_URL_STR]];
}


- (IBAction)sponsor5BtnPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SPONSOR_5_URL_STR]];
}


- (IBAction)sponsor6BtnPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SPONSOR_6_URL_STR]];
}


- (IBAction)sponsor7BtnPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SPONSOR_7_URL_STR]];
}

- (IBAction)sponsor8BtnPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SPONSOR_8_URL_STR]];
}

- (IBAction)sponsor9BtnPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SPONSOR_9_URL_STR]];
}

@end
