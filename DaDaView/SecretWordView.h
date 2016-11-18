//
//  SecretWordView.h
//  DaDaView
//
//  Created by chaoyang805 on 2016/11/8.
//  Copyright © 2016年 chaoyang805. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecretWordView : UIView

@property (nonatomic, copy) NSString *secretWord;

- (instancetype)initWithWord:(NSString *)secretWord;
- (instancetype)initWithWord:(NSString *)secretWord animatingColors:(NSArray<UIColor *> *)colors;

+ (instancetype)secretViewWithWord:(NSString *)secretWord;
+ (instancetype)secretViewWithWord:(NSString *)secretWord animatingColors:(NSArray<UIColor *> *)colors;

- (void)startAnimating;
- (void)stopAnimating;

- (void)setSecretWord:(NSString *)secretWord;

@end
