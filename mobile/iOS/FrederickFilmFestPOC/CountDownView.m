//
//  CountDownView.m
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/14/12.
//
//

#import "CountDownView.h"
#import "DigitCountView.h"


@interface CountDownView()

-(void)initCountDown:(NSDate *)targetDate;
-(void)updateCountDown;
-(void)buildView;
-(UIImage *)backgroundForView;

-(UILabel *)genLabelWithText:(NSString *)labelTxt;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIImage *bgImg;
@property (nonatomic, strong) DigitCountView *daysCDView;
@property (nonatomic, strong) DigitCountView *hoursCDView;
@property (nonatomic, strong) DigitCountView *minsCDView;
@property (nonatomic, strong) DigitCountView *secsCDView;

@property (nonatomic, strong) UILabel *captionLbl;

@end

@implementation CountDownView
@synthesize countDownDate = _countDownDate;
@synthesize daysCDView = _daysCDView;
@synthesize hoursCDView = _hoursCDView;
@synthesize minsCDView = _minsCDView;
@synthesize secsCDView = _secsCDView;
@synthesize bgImg = _bgImg;
@synthesize captionLbl = _captionLbl;
@synthesize caption = _caption;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
       [self buildView]; 
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self buildView];
        //[self setBackgroundColor:[UIColor blueColor]];
        self.bgImg = [self backgroundForView];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame andCountDownDate:(NSDate *) countdownDate {
    self = [self initWithFrame:frame];
    
    if (self) {
        self.countDownDate = countdownDate;
    }
    
    return self;
}


- (void)setCountDownDate:(NSDate *)countDownDate {
   _countDownDate = countDownDate;
    
    [self initCountDown:_countDownDate];
}

-(void)timerHandler {
    [self updateCountDown];
}


- (void)setCaption:(NSString *)caption {
    
    
    _caption = caption;
    
    [self.captionLbl setText:_caption];
}

-(UILabel *)genLabelWithText:(NSString *)labelTxt {
    UILabel *lbl = [[UILabel alloc] init];
    [lbl setTextColor:LABEL_CLR];
    [lbl setBackgroundColor:[UIColor clearColor]];
    //[lbl setFont:[UIFont systemFontOfSize:LABEL_FONT_SIZE]];
    [lbl setFont:[UIFont fontWithName:LABEL_FONT_NAME size:LABEL_FONT_SIZE]];
    [lbl setText:labelTxt];
    
    return lbl;
}

-(UIImage *)backgroundForView {    
    UIImage *bg = [[UIImage imageNamed:COUNT_DOWN_BG_IMG] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    
    return bg;
}

-(void)buildView {
    float captionHeight = 20.0;
    
    float topPadding = 3.0;
    float leftPadding = 15.0;
    float labelWidth = 50.0;
    float labelHeight = 20.0;
    float labelOffset = labelWidth + 5.0;
    float yPadding = 2.0;
    float digitWidth = 30.0;
    
    float totalDigitWidth = leftPadding + (labelOffset*4);
    
    //set up layers
    CGRect captionRect = CGRectMake(4, topPadding, totalDigitWidth - 8.0, captionHeight); //to add a small 4 point buffer space
    self.captionLbl = [[UILabel alloc] initWithFrame:captionRect];
    [self.captionLbl setTextColor:[UIColor whiteColor]];
    [self.captionLbl setBackgroundColor:[UIColor clearColor]];
    //[self.captionLbl setFont:[UIFont boldSystemFontOfSize:CAPTION_FONT_SIZE]];
    [self.captionLbl setFont:[UIFont fontWithName:LABEL_FONT_NAME size:CAPTION_FONT_SIZE]];
    [self.captionLbl setTextAlignment:NSTextAlignmentCenter];
    //[self.captionLbl setMinimumFontSize:10.0];
    [self.captionLbl setText:self.caption];
    [self addSubview:self.captionLbl];
    
    CGRect curRect = CGRectMake(leftPadding, captionHeight + yPadding, labelWidth, labelHeight);
    
    UILabel *daysLbl = [self genLabelWithText:@"Days"];
    [daysLbl setFrame:curRect];
    [self addSubview:daysLbl];
    
    UILabel *hoursLbl = [self genLabelWithText:@"Hours"];
    curRect.origin.x += labelOffset;
    [hoursLbl setFrame:curRect];
    [self addSubview:hoursLbl];
    
    UILabel *minsLbl = [self genLabelWithText:@"Minutes"];
    curRect.origin.x += labelOffset;
    [minsLbl setFrame:curRect];
    [self addSubview:minsLbl];
    
    UILabel *secsLbl = [self genLabelWithText:@"Seconds"];
    curRect.origin.x += labelOffset;
    [secsLbl setFrame:curRect];
    [self addSubview:secsLbl];
    
    
    //lay out digits
    CGRect curDigitRect =
        CGRectMake(leftPadding, curRect.origin.y + curRect.size.height + yPadding, digitWidth, digitWidth);
    
    self.daysCDView = [[DigitCountView alloc] initWithFrame:curDigitRect];
    [self addSubview:self.daysCDView];
    //[self.daysCDView release];
    
    curDigitRect.origin.x += labelOffset;
    self.hoursCDView = [[DigitCountView alloc] initWithFrame:curDigitRect];
    [self addSubview:self.hoursCDView];
    //[self.hoursCDView release];
    
    curDigitRect.origin.x += labelOffset;
    self.minsCDView = [[DigitCountView alloc] initWithFrame:curDigitRect];
    [self addSubview:self.minsCDView];
    //[self.minsCDView release];
    
    curDigitRect.origin.x += labelOffset;
    self.secsCDView = [[DigitCountView alloc] initWithFrame:curDigitRect];
    [self addSubview:self.secsCDView];
    //[self.secsCDView release];
    
}

-(void)updateCountDown {
    NSUInteger secDetla = 0;
    NSUInteger minDelta = 0;
    NSUInteger hourDelta = 0;
    NSUInteger dayDelta = 0;
    
    NSDate *curDate = [NSDate date];
    
    if ([curDate compare:self.countDownDate] == NSOrderedDescending) {
        self.caption = @"Countdown ended";
        //[self.timer invalidate];
    } else {
    
        NSTimeInterval timeDelta = [self.countDownDate timeIntervalSinceDate:[NSDate date]];
        
        secDetla  = (NSUInteger)timeDelta % 60;
        minDelta  = (NSUInteger)(timeDelta/60) % 60;
        hourDelta = (NSUInteger)(timeDelta/3600) % 24;
        dayDelta  = (NSUInteger)(timeDelta/3600)/24;
    }
    
    [self.daysCDView setValue:dayDelta];
    [self.hoursCDView setValue:hourDelta];
    [self.minsCDView setValue:minDelta];
    [self.secsCDView setValue:secDetla];
    
}

-(void)initCountDown:(NSDate *)targetDate {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                              target:self
                                            selector:@selector(timerHandler)
                                            userInfo:nil
                                             repeats:YES];
   
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self.bgImg drawInRect:rect];
}

@end
