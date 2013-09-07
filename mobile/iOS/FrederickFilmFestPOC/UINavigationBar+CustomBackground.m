//
//  UINavigationBar+CustomBackground.m
//  ILoveHem
//
//  Created by Mass Defect on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBar+CustomBackground.h"

@implementation UINavigationBar (UINavigationBar_CustomBackground)
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"navBar.png"];
    
    [image drawInRect:rect];
}

@end
