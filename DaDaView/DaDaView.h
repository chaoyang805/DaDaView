//
//  DaDaView.h
//  DaDaView
//
//  Created by chaoyang805 on 2016/11/8.
//  Copyright © 2016年 chaoyang805. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaDaView : UIView

@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *passportCode;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *busId;
@property (nonatomic, strong) NSDate *date;

- (void)startAnimating;
- (void)stopAnimating;

- (void)setBusId:(NSString *)busId;
- (NSString *)busId;

- (void)setPassword:(NSString *)password;
- (NSString *)password;

- (void)setPhoneNumber:(NSString *)phoneNumber;
- (NSString *)phoneNumber;

- (void)setPassportCode:(NSString *)passportCode;
- (NSString *)passportCode;

- (void)setDate:(NSDate *)date;
- (NSDate *)date;

@end
