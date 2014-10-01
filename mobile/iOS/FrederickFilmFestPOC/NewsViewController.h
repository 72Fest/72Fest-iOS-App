//
//  NewsViewController.h
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/11/14.
//
//

#import <UIKit/UIKit.h>
#import "GenericWebContentViewController.h"

@interface NewsViewController : GenericWebContentViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
