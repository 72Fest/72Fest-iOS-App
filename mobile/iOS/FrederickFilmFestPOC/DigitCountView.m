//
//  DigitCountView.m
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/15/12.
//
//

#import "DigitCountView.h"

#define IMAGE_DIGIT_DIMENSION_W 20.0
#define IMAGE_DIGIT_DIMENSION_H 30.0

@interface DigitCountView() {
    NSUInteger curDigit1;
    NSUInteger curDigit2;
}

- (void)layoutDigits:(CGRect)frame;
- (UILabel *)setupLabel:(CGRect)frame;
- (UIImage *)imageForDigit:(NSInteger)digit;

@property (nonatomic, strong) UIImageView *digit1a;
@property (nonatomic, strong) UIImageView *digit1b;

@property (nonatomic, strong) UIImageView *digit2a;
@property (nonatomic, strong) UIImageView *digit2b;

@end

@implementation DigitCountView
@synthesize value = _value;

@synthesize digit1a = _digit1a;
@synthesize digit1b = _digit1b;
@synthesize digit2a = _digit2a;
@synthesize digit2b = _digit2b;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutDigits:frame];
    }
    return self;
}

- (void)layoutDigits:(CGRect)frame {
    float w = IMAGE_DIGIT_DIMENSION_W;
    float h = IMAGE_DIGIT_DIMENSION_H;
    CGRect frame1 = CGRectMake(0, 0, w, h);
    CGRect frame2 = CGRectMake(w, 0, w, h);
    
    
    curDigit1 = 0;
    curDigit2 = 0;
    
    self.digit1a = [[UIImageView alloc] initWithImage:[self imageForDigit:0]];
    self.digit1b = [[UIImageView alloc] initWithImage:[self imageForDigit:0]];
    [self.digit1a setFrame:frame1];
    [self.digit1b setFrame:frame1];
    
    self.digit2a = [[UIImageView alloc] initWithImage:[self imageForDigit:0]];
    self.digit2b = [[UIImageView alloc] initWithImage:[self imageForDigit:0]];;
    [self.digit2a setFrame:frame2];
    [self.digit2b setFrame:frame2];
    
    [self addSubview:self.digit1b];
    [self addSubview:self.digit1a];
    [self addSubview:self.digit2b];
    [self addSubview:self.digit2a];
}

- (UIImage *)imageForDigit:(NSInteger)digit {
    return [UIImage imageNamed:[NSString stringWithFormat:@"digit%d",digit]];
}

- (UILabel *)setupLabel:(CGRect)frame {
    UILabel *lbl = [[UILabel alloc] initWithFrame:frame];
    
    [lbl setAdjustsFontSizeToFitWidth:YES];
    return lbl;
}

- (void)setValue:(NSUInteger)value {
    if (value > 99)
        value = 99;
    
    NSInteger digit1 = value/10;
    NSInteger digit2 = value % 10;
    
    if (digit1 != curDigit1) {
        [self.digit1a setImage:[self imageForDigit:digit1]];
    }
    
    if (digit2 != curDigit2) {
        [self.digit2a setImage:[self imageForDigit:digit2]];
    }
    
    curDigit1 = digit1;
    curDigit2 = digit2;
    
    _value = value;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
