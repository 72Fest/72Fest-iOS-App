//
//  UIImage+Color.h
//  ILoveHem
//
//  Created by Carpe Lucem Media Group on 6/29/13.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color andBounds:(CGRect)imgBounds;
@end
