//
//  DSVerticalSliderView.h
//  HeroCity
//
//  Created by cgw on 2019/3/20.
//  Copyright © 2019 cgw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSVerticalSliderView : UIView

- (id)initWithFrame:(CGRect)frame; 

@property (nonatomic, strong) UISlider *slider;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) void(^HandleBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
