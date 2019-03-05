//
//  DSApiManager.h
//  DSComponents
//
//  Created by cgw on 2019/3/5.
//  Copyright © 2019 bill. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 功能：提供网络请求接口
 本层的作用：网络判断，参数检测，主动/自动取消网络请求
 */
@interface DSApiManager : NSObject

+ (DSApiManager*)sharedInstance;

/**
 请求网路数据

 @param url 接口地址
 @param parameters 参数
 @param parametersCanNull 参数是否可以为nil
 @param caller 调用者
 @param isGet 是否是Get请求
 @param configRequest 配置request的回调，调用者可在此回调中，对request进行额外的配置
 @param complete 完成回调
 */
- (void)requestDataWithUrl:(NSString*)url
                parameters:(NSDictionary *)parameters
          parameterCanNull:(BOOL)parametersCanNull
                    caller:(NSObject*)caller
                     isGet:(BOOL)isGet
             configRequest:(nullable void(^)(NSMutableURLRequest *request))configRequest
                  complete:(void (^)(NSData *, NSError *))complete;

/**
 取消某个请求
 
 @param requestID 该请求的ID
 */
- (void)cancelRequestWithRequestId:(NSInteger)requestID;

@end

NS_ASSUME_NONNULL_END
