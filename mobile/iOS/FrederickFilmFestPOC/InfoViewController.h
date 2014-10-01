//
//  InfoViewController.h
//  FrederickFilmFestPOC
//
//  Created by Mass Defect on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InfoViewController : UIViewController {
    IBOutlet UIButton *dismissBtn;
    IBOutlet UILabel *urlLabel;
    IBOutlet UILabel *designUrlLabel;
}

-(void)btnPressed:(id)sender;
//IB actions

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (IBAction)bannerPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *siteBannerBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end
