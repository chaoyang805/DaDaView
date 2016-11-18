//
//  UIButton+UIButton_Boardered.m
//  DaDaView
//
//  Created by chaoyang805 on 2016/11/8.
//  Copyright © 2016年 chaoyang805. All rights reserved.
//

#import "UIButton+BorderedButton.h"

@implementation UIButton (BorderedButton)
+ (instancetype)borderedButtonWithBorderWidth:(CGFloat)width color:(UIColor*)color cornerRadius:(CGFloat)radius {
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    btn.layer.borderColor = color.CGColor;
    btn.layer.cornerRadius = radius;
    btn.layer.borderWidth = width;
    return btn;
}
@end
