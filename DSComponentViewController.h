//
//  DSComponentViewController.h
//  DSComponents
//
//  Created by cgw on 2019/2/14.
//  Copyright © 2019 bill. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSComponentViewController : UIViewController

@end

@interface DSComponentViewController(RootCtrl)

+ (UIViewController*)rootCtrl;

@end

NS_ASSUME_NONNULL_END
