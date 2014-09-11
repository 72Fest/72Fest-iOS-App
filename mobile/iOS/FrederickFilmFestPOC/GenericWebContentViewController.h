//
//  GenericWebContentViewController.h
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/11/14.
//
//

#import <UIKit/UIKit.h>

@interface GenericWebContentViewController : UIViewController <UIWebViewDelegate>
- (id)initWithURL:(NSURL *)url andLoadingCaption:(NSString *)captionStr;

@property (strong, nonatomic) NSString *loadingCaptionStr;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
