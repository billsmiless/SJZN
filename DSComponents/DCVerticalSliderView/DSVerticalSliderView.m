//
//  DSVerticalSliderView.m
//  HeroCity
//
//  Created by cgw on 2019/3/20.
//  Copyright © 2019 cgw. All rights reserved.
//

#import "DSVerticalSliderView.h"
#import "UIView+LayoutMethods.h"
#import "DSContentButton.h"
#import "UIColor+NewExt.h"

@interface DSVerticalSlider : UISlider

@end

@implementation DSVerticalSliderView{
    UIView *_bgView;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if( self ){
        
        CGSize size = frame.size;

        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        CGFloat iw = 25,ih = 208;
        _bgView.frame = CGRectMake((size.width-iw)/2, (size.height-ih)/2, iw, ih);
        [_bgView cornerRadius:iw/2];
        [self addSubview:_bgView];

        CGFloat wh = 44, showHeightAtBgView = 23; //按钮的大小以及展示在bgView上的高度
        DSContentButton *plusBtn = [[DSContentButton alloc] initWithCornerRadius:0 borderWidth:0 borderColor:nil];
        plusBtn.frame = CGRectMake((size.width-wh)/2, _bgView.y+showHeightAtBgView-wh, wh, wh);
        plusBtn.contentRect = CGRectMake(0, wh-showHeightAtBgView, wh, showHeightAtBgView);
        [plusBtn setImage:[UIImage imageNamed:@"slider_plus"] forState:UIControlStateNormal];
        [plusBtn addTarget:self action:@selector(plus) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];

        DSContentButton *minusBtn = [[DSContentButton alloc] initWithCornerRadius:0 borderWidth:0 borderColor:nil];
        minusBtn.frame = CGRectMake(plusBtn.x, _bgView.bottom-showHeightAtBgView, wh, wh);
        minusBtn.contentRect = CGRectMake(0, 0, wh, showHeightAtBgView);
        [minusBtn setImage:[UIImage imageNamed:@"slider_minus"] forState:UIControlStateNormal];
        [minusBtn addTarget:self action:@selector(minus) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:minusBtn];

        iw = _bgView.height-2*showHeightAtBgView;
        _slider = [[DSVerticalSlider alloc] initWithFrame:CGRectMake(0, 0, iw, 15)];
        _slider.center = CGPointMake(_bgView.width/2, _bgView.height/2);
        _slider.minimumValue = 0;
        _slider.maximumValue = 90;
        _slider.value = 0;
        _slider.continuous = NO;
        [_slider addTarget:self action:@selector(handleSlider:) forControlEvents:UIControlEventValueChanged];
        [_bgView addSubview:_slider];
        [self setupSider:_slider];
        
        [self rotate90Agree];
    }
    
    return self;
}

- (void)rotate90Agree{
    CGAffineTransform rotation =CGAffineTransformMakeRotation((-M_PI*1/2));
    [self.slider setTransform:rotation];
}

- (void)setupSider:(UISlider *)slider{

    UIImage *slImage = [UIImage imageNamed:@"slider_dot"];
    [slider setMaximumTrackTintColor:[UIColor colorWithRgb221]];
    [slider setMinimumTrackTintColor:[UIColor colorWithRgb59_127_224]];
    [slider setThumbImage:slImage forState:UIControlStateNormal];
}

#pragma mark - TouchEvents

- (void)minus{
    NSLog(@"%s",__func__);
    CGFloat moveValue = [self moveDistanceEveryTime];
    CGFloat value = self.slider.value-moveValue;
    [self.slider setValue:value animated:YES];
    
    [self handleSliderWithIndex:value/moveValue];
}

- (void)plus{
     NSLog(@"%s",__func__);
    CGFloat moveValue = [self moveDistanceEveryTime];
    CGFloat value = self.slider.value+moveValue;
    [self.slider setValue:value animated:YES];
    
    [self handleSliderWithIndex:value/moveValue];
}

- (void)handleSlider:(UISlider*)slider{
     NSLog(@"%s",__func__);
    NSInteger moveValue = (NSInteger)[self moveDistanceEveryTime];
    int value = slider.value;
    int rest = value%moveValue;
    int ret =value/moveValue;
    NSInteger idx = ret;
    if( rest > moveValue/2.0 ){
        idx++;
        [slider setValue:(ret+1)*moveValue animated:YES];
    }else{
        [slider setValue:(ret)*moveValue animated:YES];
    }
    
    [self handleSliderWithIndex:idx];
}

- (void)handleSliderWithIndex:(NSInteger)idx{
    _index = idx;
    if( _HandleBlock ){
        _HandleBlock(idx);
    }
}

//每次点击或拖动后，移动固定的距离值。
- (CGFloat)moveDistanceEveryTime{
    return 30;
}

@end


@implementation DSVerticalSlider

- (CGRect)trackRectForBounds:(CGRect)bounds{
    return CGRectMake(0, (bounds.size.height-5)/2, bounds.size.width, 5);
}

@end
