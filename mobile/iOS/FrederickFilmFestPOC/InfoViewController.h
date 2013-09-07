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
- (IBAction)dismissPressed:(id)sender;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (IBAction)bannerPressed:(id)sender;

@property (retain, nonatomic) IBOutlet UIImageView *siteBannerBtn;

@end
