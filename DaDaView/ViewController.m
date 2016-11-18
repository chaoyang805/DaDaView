//
//  ViewController.m
//  DaDaView
//
//  Created by chaoyang805 on 2016/11/8.
//  Copyright © 2016年 chaoyang805. All rights reserved.
//

#import "ViewController.h"
#import "DaDaView.h"

@interface ViewController ()

@property (nonatomic, strong) DaDaView *dadaView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    self.dadaView = [[DaDaView alloc] initWithFrame:CGRectMake(20, 84, 335, 500)];
    self.dadaView.phoneNumber = @"13788747078";
    self.dadaView.password = @"上车啦";
    self.dadaView.passportCode = @"1010";
    self.dadaView.busId = @"京A8888";
    [self.view addSubview:self.dadaView];
    
    self.navigationItem.title = @"嗒嗒电子票";
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewdidAppear");
    [self.dadaView startAnimating];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
    [self.dadaView stopAnimating];
}

@end
