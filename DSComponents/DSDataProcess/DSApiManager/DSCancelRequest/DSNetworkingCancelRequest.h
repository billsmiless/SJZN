//
//  DSNetworkingCancelRequest.h
//  WKDemo
//
//  Created by cgw on 2018/9/8.
//  Copyright © 2018 cgw. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DSApiManager;
@interface DSNetworkingCancelRequest : NSObject
- (void)setManager:(DSApiManager*)manager requestID:(NSNumber*)requestID;
- (void)removeManagerWithRequestID:(NSNumber*)requestID;

- (void)cancleAllRequestAndRemoveManagers;

/**
 因为一个调用者可能执行多个请求，当需要取消某一个请求时，使用tag标记请求。不需要主动取消的，则不需要标记tag.

 @param tag 请求ID的标记。
 */
- (void)cancelRequestWithTag:(NSUInteger)tag;
@end
