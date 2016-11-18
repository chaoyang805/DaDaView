//
//  DaDaView.m
//  DaDaView
//
//  Created by chaoyang805 on 2016/11/8.
//  Copyright © 2016年 chaoyang805. All rights reserved.
//

#import "DaDaView.h"
#import "UIButton+BorderedButton.h"
#import "SecretWordView.h"
#import "UIColor+HexStringColor.h"

static const CGFloat kCornerRadiusTop = 20;
static const CGFloat kCornerRadiusBottom = 16;
static const CGFloat kBottomBarHeight = 60;

@interface DaDaView ()

@property (nonatomic, readonly, assign) CGFloat width;
@property (nonatomic, readonly, assign) CGFloat height;

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *busIdLabel;
@property (nonatomic, strong) UIButton *ratingButton;
@property (nonatomic, strong) UILabel *passportCodeLabel;
@property (nonatomic, strong) UILabel *phoneNumberLabel;
@property (nonatomic, strong) SecretWordView *secretWordView;

@end

@implementation DaDaView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setBusId:(NSString *)busId {
    _busId = [busId copy];
    self.busIdLabel.text = busId;
}

- (void)setPhoneNumber:(NSString *)phoneNumber {
    _phoneNumber = [phoneNumber copy];
    self.phoneNumberLabel.text = [NSString stringWithFormat:@"手机号：%@", phoneNumber];
}

- (void)setPassportCode:(NSString *)passportCode {
    _passportCode = [passportCode copy];
    self.passportCodeLabel.attributedText = [self attributeTextForPassportCode:passportCode];
}

- (void)setPassword:(NSString *)password {
    _password = [password copy];
    self.secretWordView.secretWord = password;
}

- (void)setDate:(NSDate *)date {
    _date = date;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM月dd日 HH:mm";
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    NSString* nowStr = [formatter stringFromDate:date];
    self.dateLabel.text = nowStr;
    [self.dateLabel sizeToFit];
}

- (NSAttributedString *)attributeTextForPassportCode:(NSString *)passportCode {
    NSString *passportString = [NSString stringWithFormat:@"验票码：%@", passportCode];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:passportString];
    
    UIColor *textColorLight = [UIColor colorWithHexString:@"0x797979"];
    UIColor *textColorDark = [UIColor colorWithHexString:@"0x666666"];
    
    UIFont *textFontSmall = [UIFont systemFontOfSize:13];
    UIFont *textFontLarge = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    
    [attributedString addAttributes:@{
                                      NSForegroundColorAttributeName: textColorLight,
                                      NSFontAttributeName: textFontSmall
                                      }
                              range:NSMakeRange(0, 4)];
    [attributedString addAttributes:@{
                                      NSForegroundColorAttributeName: textColorDark,
                                      NSFontAttributeName: textFontLarge
                                      }
                              range:NSMakeRange(4, attributedString.length - 4)];
    
    return [attributedString copy];
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor clearColor];
    self.layer.shadowColor = [UIColor colorWithHexString:@"0xcccccc"].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowOpacity = 0.5;
    
    // 日期 label
    _dateLabel = [[UILabel alloc] init];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM月dd日 HH:mm";
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    NSString* nowStr = [formatter stringFromDate:[NSDate new]];
    _dateLabel.text = nowStr;
    _dateLabel.textColor = [UIColor darkGrayColor];
    [_dateLabel sizeToFit];
    [self addSubview:_dateLabel];
    
    // 车牌 label
    _busIdLabel = [[UILabel alloc] init];
    _busIdLabel.text = @"京AX7515";
    _busIdLabel.font = [UIFont systemFontOfSize:32 weight:UIFontWeightBold];
    _busIdLabel.textColor = [UIColor blackColor];
    [_busIdLabel sizeToFit];
    [self addSubview:_busIdLabel];
    
    // 带边框的 Button
    UIColor* borderColor = [UIColor colorWithRed:1 green:0.61 blue:0 alpha:1];
    _ratingButton = [UIButton borderedButtonWithBorderWidth:1.5 color:borderColor cornerRadius:5];
    [_ratingButton setTitle:@"评价一下" forState:UIControlStateNormal];
    [_ratingButton setTitleColor:borderColor forState:UIControlStateNormal];
    _ratingButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_ratingButton sizeToFit];
    [self addSubview:_ratingButton];

    // 验票的 view
    _secretWordView = [SecretWordView secretViewWithWord:@"哈哈哈"];
    _secretWordView.frame = CGRectMake(0, 0, self.width, 240);
    [self addSubview:_secretWordView];
    
    
    UIColor *textColorLight = [UIColor colorWithHexString:@"0x797979"];
    
    // 验票码
    _passportCodeLabel = [UILabel new];
    _passportCodeLabel.attributedText = [self attributeTextForPassportCode:@"5499"];
    [_passportCodeLabel sizeToFit];
    [self addSubview:_passportCodeLabel];
    
    // 手机号
    _phoneNumberLabel = [UILabel new];
    _phoneNumberLabel.text = [NSString stringWithFormat:@"手机号：%@", @"18338318333"];
    _phoneNumberLabel.textColor = textColorLight;
    _phoneNumberLabel.font = [UIFont systemFontOfSize:12];
    [_phoneNumberLabel sizeToFit];
    [self addSubview:_phoneNumberLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.dateLabel.frame = CGRectMake(
                                      kCornerRadiusTop,
                                      40,
                                      CGRectGetWidth(self.dateLabel.bounds),
                                      CGRectGetHeight(self.dateLabel.bounds)
                                      );
    
    self.busIdLabel.frame = CGRectMake(
                                       kCornerRadiusTop,
                                       CGRectGetMaxY(self.dateLabel.frame),
                                       CGRectGetWidth(self.busIdLabel.bounds),
                                       CGRectGetHeight(self.busIdLabel.bounds)
                                       );
    
    self.secretWordView.frame = CGRectMake(
                                           0,
                                           CGRectGetMaxY(self.busIdLabel.frame) + 20,
                                           self.width,
                                           240
                                           );
    self.ratingButton.frame = CGRectMake(
                                         self.width * 0.1,
                                         CGRectGetMaxY(self.secretWordView.frame) + 20,
                                         self.width * 0.8,
                                         44
                                         );
    
    CGFloat x = self.width - CGRectGetWidth(self.passportCodeLabel.bounds) - 20;
    CGFloat y = self.height - kBottomBarHeight + 10;
    self.passportCodeLabel.frame = CGRectMake(
                                              x,
                                              y,
                                              CGRectGetWidth(self.passportCodeLabel.bounds),
                                              CGRectGetHeight(self.passportCodeLabel.bounds)
                                              );
    x = self.width - CGRectGetWidth(self.phoneNumberLabel.bounds) - 20;
    y = CGRectGetMaxY(self.passportCodeLabel.frame) + 5;
    self.phoneNumberLabel.frame = CGRectMake(
                                             x,
                                             y,
                                             CGRectGetWidth(self.phoneNumberLabel.bounds),
                                             CGRectGetHeight(self.phoneNumberLabel.bounds)
                                             );
}

- (void)startAnimating {
    [self.secretWordView startAnimating];
}

- (void)stopAnimating {
    [self.secretWordView stopAnimating];
}
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] setFill];
    const CGFloat widthSpacing = (self.bounds.size.width - 4 * kCornerRadiusTop) / 2;
    const CGFloat heightSpacing = self.bounds.size.height - kCornerRadiusTop - kCornerRadiusBottom - 60;
    // 画外边框
    CGContextMoveToPoint(context, 0, kCornerRadiusTop);
    CGContextAddArcToPoint(context, kCornerRadiusTop, kCornerRadiusTop, kCornerRadiusTop, 0, kCornerRadiusTop);
    CGContextAddLineToPoint(context, widthSpacing + kCornerRadiusTop, 0);
    CGContextAddArcToPoint(context, widthSpacing + kCornerRadiusTop, kCornerRadiusTop, widthSpacing + 2 * kCornerRadiusTop, kCornerRadiusTop, kCornerRadiusTop);
    CGContextAddArcToPoint(context, widthSpacing + 3 * kCornerRadiusTop, kCornerRadiusTop, widthSpacing + 3 * kCornerRadiusTop, 0, kCornerRadiusTop);
    CGContextAddLineToPoint(context, self.width - kCornerRadiusTop, 0);
    CGContextAddArcToPoint(context, self.width - kCornerRadiusTop, kCornerRadiusTop, self.width, kCornerRadiusTop, kCornerRadiusTop);
    CGContextAddLineToPoint(context, self.width, heightSpacing + kCornerRadiusTop);
    CGContextAddArcToPoint(context, self.width - kCornerRadiusBottom, heightSpacing + kCornerRadiusTop, self.width - kCornerRadiusBottom, heightSpacing + kCornerRadiusTop + kCornerRadiusBottom, kCornerRadiusBottom);
    CGContextAddLineToPoint(context, kCornerRadiusBottom, heightSpacing + kCornerRadiusTop + kCornerRadiusBottom);
    CGContextAddArcToPoint(context, kCornerRadiusBottom, heightSpacing + kCornerRadiusTop, 0, heightSpacing + kCornerRadiusTop, kCornerRadiusBottom);
    CGContextAddLineToPoint(context, 0, kCornerRadiusTop);
    
    CGContextFillPath(context);
    
    // 绘制虚线
    CGFloat lengths[] = {2, 2};
    CGContextSetLineDash(context, 1, lengths, 2);
    CGContextSetRGBStrokeColor(context, 0.4, 0.4, 0.4, 0.53);
    CGContextSetLineWidth(context, 1);
    CGContextMoveToPoint(context, kCornerRadiusBottom, self.height - 60);
    CGContextAddLineToPoint(context, self.width - kCornerRadiusBottom, self.height - 60);
    CGContextStrokePath(context);
    
    // 绘制底部灰色区域
    CGContextSetRGBFillColor(context, 0.96, 0.96, 0.96, 1);
    CGContextMoveToPoint(context, kCornerRadiusBottom, self.height - 60);
    CGContextAddLineToPoint(context, self.width - kCornerRadiusBottom, self.height - 60);
    
    CGContextAddArcToPoint(context, self.width - kCornerRadiusBottom, self.height - 60 + kCornerRadiusBottom, self.width, self.height - 60 + kCornerRadiusBottom, kCornerRadiusBottom);
    CGContextAddLineToPoint(context, self.width, self.height);
    CGContextAddLineToPoint(context, 0, self.height);
    CGContextAddLineToPoint(context, 0, self.height - 60 + kCornerRadiusBottom);
    CGContextAddArcToPoint(context, kCornerRadiusBottom, self.height - 60 + kCornerRadiusBottom, kCornerRadiusBottom, self.height - 60, kCornerRadiusBottom);
    CGContextFillPath(context);
}

- (CGFloat)width {
    return self.bounds.size.width;
}

- (CGFloat)height {
    return self.bounds.size.height;
}

@end
