//
//  CountDownView.h
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/14/12.
//
//

#import <UIKit/UIKit.h>

#define LABEL_FONT_NAME @"Archive"
#define LABEL_FONT_SIZE 10.0
#define LABEL_CLR [UIColor colorWithRed:232.0 green:232.0 blue:232.0 alpha:1]
#define CAPTION_FONT_SIZE 12.0
#define COUNT_DOWN_BG_IMG @"digitsBackground.png"

#define COUNTDOWN_METADATA_URL @"http://putpocket.com/photoapp/countDown.php"

#define kCountdownCaption   @"caption"
#define kCountdownTime      @"time"
#define kCountdownTimeYear  @"year"
#define kCountdownTimeMonth @"month"
#define kCountdownTimeDay   @"day"
#define kCountdownTimeHour  @"hour"
#define kCountdownTimeMin   @"minute"
#define kCountdownTimeSec   @"second"

@interface CountDownView : UIView {
    NSTimer *_timer;
}

- (id)initWithFrame:(CGRect)frame andCountDownDate:(NSDate *) countdownDate;
- (void)timerHandler;

@property (nonatomic, retain) NSDate *countDownDate;
@property (nonatomic, retain) NSString *caption;

@end
