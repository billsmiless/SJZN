//
//  DSSheetSelectView.h
//  DSComponents
//
//  Created by cgw on 2019/4/18.
//  Copyright © 2019 bill. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef DSSHEETSELECTVIEW
#define DSSHEETSELECTVIEW

typedef void(^DSSheetSelectViewSelectedBlock)(NSInteger index);

#endif

@interface DSSheetSelectView : UIView

@property (nonatomic, strong) NSArray *datas;
+ (DSSheetSelectView*)showWithSelectedIndex:(NSInteger)sIdx datas:(NSArray<NSString*>*)datas selectedBlock:(DSSheetSelectViewSelectedBlock)selectBlock;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
