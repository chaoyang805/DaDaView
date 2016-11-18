//
//  UIButton+UIButton_Boardered.h
//  DaDaView
//
//  Created by chaoyang805 on 2016/11/8.
//  Copyright © 2016年 chaoyang805. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BorderedButton)

+ (instancetype)borderedButtonWithBorderWidth:(CGFloat)width color:(UIColor*)color cornerRadius:(CGFloat)radius;

@end
