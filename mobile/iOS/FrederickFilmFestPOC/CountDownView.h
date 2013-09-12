//
//  CountDownView.h
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/14/12.
//
//

#import <UIKit/UIKit.h>
#import "ConnectionInfo.h"

#define LABEL_FONT_NAME @"Archive"
#define LABEL_FONT_SIZE 10.0
#define LABEL_CLR [UIColor colorWithRed:232.0 green:232.0 blue:232.0 alpha:1]
#define CAPTION_FONT_SIZE 12.0
#define COUNT_DOWN_BG_IMG @"digitsBackground.png"



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

@property (nonatomic, strong) NSDate *countDownDate;
@property (nonatomic, strong) NSString *caption;

@end
