//
//  DSDataProcess.h
//  DSComponents
//
//  Created by cgw on 2019/3/5.
//  Copyright © 2019 bill. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSDataProcess : NSObject

+ (DSDataProcess*)sharedDataProcess;

- (void)test;
#pragma mark - Base


@end

NS_ASSUME_NONNULL_END
