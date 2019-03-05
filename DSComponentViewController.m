//
//  DSComponentViewController.m
//  DSComponents
//
//  Created by cgw on 2019/2/14.
//  Copyright © 2019 bill. All rights reserved.
//

#import "DSComponentViewController.h"
#import "DSDataProcess.h"

@interface DSComponentViewController ()

@end

@implementation DSComponentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *btn = [UIButton new];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(handleBtn) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:btn];
}

- (void)handleBtn{
    [[DSDataProcess sharedDataProcess] test];
}

@end

@implementation DSComponentViewController(RootCtrl)

+ (UIViewController *)rootCtrl{
    UINavigationController *naviCtrl = [[UINavigationController alloc] initWithRootViewController:[DSComponentViewController new]];
    
    return naviCtrl;
}

@end
