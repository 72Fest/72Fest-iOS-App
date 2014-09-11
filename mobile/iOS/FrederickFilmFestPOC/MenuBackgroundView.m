//
//  MenuBackgroundView.m
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/11/14.
//
//

#import "MenuBackgroundView.h"

@implementation MenuBackgroundView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self genShadow];
    }
    
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self genShadow];
    }
    return self;
}

- (void)genShadow {
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0,3);
    self.layer.shadowOpacity = 0.3;
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
