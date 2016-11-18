//
//  SecretWordView.m
//  DaDaView
//
//  Created by chaoyang805 on 2016/11/8.
//  Copyright © 2016年 chaoyang805. All rights reserved.
//

#import "SecretWordView.h"
#import "UIColor+HexStringColor.h"

static const NSTimeInterval kAnimationDuration = 1.f;
static const NSUInteger kEmojiCount = 8;
static const NSUInteger kEmojiSpacing = 10;
@interface SecretWordView ()

@property (nonatomic, copy) NSArray<UIColor *> *animatingColors;
@property (nonatomic, strong) UILabel *secretWordLabel;
@property (nonatomic, strong) CALayer *animationLayer;
@property (nonatomic, copy) NSArray<NSString *> *images;
@end

@implementation SecretWordView {
    NSTimer *_timer;
    NSUInteger _currentIndex;
}

- (instancetype)initWithWord:(NSString *)secretWord {
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
        
        _secretWord = [secretWord copy];
        
        UIColor *color1 = [UIColor colorWithHexString:@"0xBEDEFF"];
        UIColor *color2 = [UIColor colorWithHexString:@"0xBEF9E0"];
        UIColor *color3 = [UIColor colorWithHexString:@"0xFFF5C5"];
        UIColor *color4 = [UIColor colorWithHexString:@"0xFFD1F1"];
        _animatingColors = @[color1, color2, color3, color4];
        
        _secretWordLabel = [[UILabel alloc] init];
        _secretWordLabel.text = _secretWord;
        _secretWordLabel.font = [UIFont systemFontOfSize:88 weight:UIFontWeightBold];
        _secretWordLabel.textColor = [UIColor colorWithHexString:@"0x0051B2"];
        [_secretWordLabel sizeToFit];
        [self addSubview:_secretWordLabel];
    }
    return self;
}
- (instancetype)initWithWord:(NSString *)secretWord animatingColors:(NSArray<UIColor *> *)colors {
    self = [super init];
    if (self) {
        self = [self initWithWord:secretWord];
        _animatingColors = [colors copy];
    }
    return self;
}

+ (instancetype)secretViewWithWord:(NSString *)secretWord {
    return [[SecretWordView alloc] initWithWord:secretWord];
}

+ (instancetype)secretViewWithWord:(NSString *)secretWord animatingColors:(NSArray<UIColor *> *)colors {
    return [[SecretWordView alloc] initWithWord:secretWord animatingColors:colors];
}

- (void)setSecretWord:(NSString *)secretWord {
    
    _secretWord = [secretWord copy];
    _secretWordLabel.text = _secretWord;
    [_secretWordLabel sizeToFit];
}

- (CALayer *)animationLayer {
    if (!_animationLayer) {
        _animationLayer = [CALayer layer];
        _animationLayer.frame = self.bounds;
        _animationLayer.backgroundColor = self.animatingColors.firstObject.CGColor;
        _currentIndex = 0;
    }
    return _animationLayer;
}

- (NSArray<NSString *> *)images {
    if (!_images) {
        _images = @[@"d_doge", @"d_aini", @"d_chanzui", @"d_miao",
                    @"d_taikaixin", @"d_xiaoku", @"d_qinqin", @"d_yinxian"];
    }
    return _images;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.secretWordLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self.layer addSublayer:self.animationLayer];
    [self bringSubviewToFront:self.secretWordLabel];
//    [self startAnimating];
    
}

- (CAAnimation *)dropAnimation {
    
    CABasicAnimation *dropAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    dropAnimation.repeatCount = INFINITY;
    dropAnimation.byValue = [NSValue valueWithCGPoint:CGPointMake(0, self.bounds.size.height + 50)];
    dropAnimation.duration = (5 + arc4random_uniform(10)) / 10.f ;
    
    return dropAnimation;
}

- (void)startAnimating {
    
    // animating background
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:kAnimationDuration target:self selector:@selector(animateBgColor) userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    // animating drop emojis
    
    CGFloat min = MIN(self.bounds.size.width, self.bounds.size.height);
    const CGFloat emojiWidth = min / kEmojiCount;
    
    for (NSUInteger i = 0; i < kEmojiCount; i++) {
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(i * (emojiWidth + kEmojiSpacing) + kEmojiSpacing, -emojiWidth, emojiWidth, emojiWidth);
        layer.contents = (__bridge id _Nullable)([UIImage imageNamed:self.images[i]].CGImage);
        
        [self.layer addSublayer:layer];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(arc4random_uniform(1500) * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            [layer addAnimation:[self dropAnimation] forKey:@"dropAnim"];
        });
    }

}

- (void)stopAnimating {
    if ([_timer isValid]) {

        [_timer invalidate];
        _timer = nil;
    }
    for (CALayer *sublayer in self.layer.sublayers) {
        [sublayer removeAllAnimations];
    }
}

- (void)animateBgColor {
    [CATransaction begin];
    [CATransaction setAnimationDuration:kAnimationDuration];
    _currentIndex = ++_currentIndex % self.animatingColors.count;
    
    self.animationLayer.backgroundColor = self.animatingColors[_currentIndex].CGColor;
    [CATransaction commit];
    
}

- (void)dealloc {
//    [self stopAnimating];
}

@end
