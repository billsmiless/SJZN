//
//  DSNavigationController.m
//  DSComponents
//
//  Created by cgw on 2019/3/6.
//  Copyright © 2019 bill. All rights reserved.
//

#import "DSNavigationController.h"

@interface DSNavigationController ()<UINavigationBarDelegate>

@end

@implementation DSNavigationController

- (instancetype)init{
    self = [super init];
    if( self ){
        self.navigationBar.delegate = self;
    }
    return self;
}

#pragma mark - NaviagtionBarDelegate
//为了解决根视图从左侧滑动卡死问题
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item{
    //只有一个控制器的时候禁止手势，防止卡死现象
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    if (self.childViewControllers.count > 1) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = YES;
        }
    }
    return YES;
}

- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
    //只有一个控制器的时候禁止手势，防止卡死现象
    if (self.childViewControllers.count == 1) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

@end
