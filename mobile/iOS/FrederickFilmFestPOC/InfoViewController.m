//
//  InfoViewController.m
//  FrederickFilmFestPOC
//
//  Created by Mass Defect on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InfoViewController.h"
#import "ConnectionInfo.h"


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
    UIImageView *iv =
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"filmFestLogo.png"]];
    [[self navigationItem] setTitleView:iv];
    
    //set background
    CGRect frame = self.view.frame;
    UIView *v = [[UIView alloc] initWithFrame:frame];
    UIImage *i = [UIImage imageNamed:@"bkg.png"];
    UIColor *c = [[UIColor alloc] initWithPatternImage:i];
    v.backgroundColor = c;
    [[self view] insertSubview:v atIndex:0];
    
    UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(btnPressed:)];
    self.navigationItem.rightBarButtonItem = closeBtn;
    
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - IB Actions
- (IBAction)dismissPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
