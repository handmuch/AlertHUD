//
//  ViewController.m
//  AlertHUD
//
//  Created by POWER on 14/10/28.
//  Copyright (c) 2014年 power. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMainView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initMainView
{
    UIButton *showButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 30, 80, 30)];
    [showButton setTitle:@"show" forState:UIControlStateNormal];
    showButton.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    [showButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [showButton addTarget:self action:@selector(showButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:showButton];
}

- (void)showButtonClick:(UIButton *)sender
{
    [self.view.window showHUDWithText:@"添加购物车成功" Enabled:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
