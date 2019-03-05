//
//  DSNetworkingCancelRequest.m
//  WKDemo
//
//  Created by cgw on 2018/9/8.
//  Copyright © 2018 cgw. All rights reserved.
//

#import "DSNetworkingCancelRequest.h"
#import "DSApiManager.h"
#import "NSObject+DSNetworkingAutoCancel.h"

@interface DSNetworkingCancelRequest()
@property (nonatomic, strong) NSMutableDictionary<NSNumber *,DSApiManager *> *requestManager;
@end

@implementation DSNetworkingCancelRequest
- (void)dealloc{
    [self cancleAllRequestAndRemoveManagers];
}

- (void)setManager:(DSApiManager *)manager requestID:(NSNumber *)requestID{
    if (manager && requestID) {
        self.requestManager[requestID] = manager;
    }
}

- (void)removeManagerWithRequestID:(NSNumber *)requestID{
    if (requestID) {
        //        NSArray *keys = self.requestEngines.allKeys;
        //        if ([keys containsObject:requestID]) {
        [self.requestManager removeObjectForKey:requestID];
        //        } else {
    }
}

- (void)cancleAllRequestAndRemoveManagers{
    [self.requestManager enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, DSApiManager * _Nonnull obj, BOOL * _Nonnull stop) {
        //        [obj cancelAllRequest];
        [obj cancelRequestWithRequestId:key.integerValue];
    }];
    [self.requestManager removeAllObjects];
    self.requestManager = nil;
}

- (void)cancelRequestWithTag:(NSUInteger)tag{
    for( NSNumber *requestId in self.requestManager.allKeys ){
        if( requestId.requestTag.integerValue == tag){
            DSApiManager *apiManager = self.requestManager[requestId];
            [apiManager cancelRequestWithRequestId:requestId.integerValue];
            break;
        }
    }
}

#pragma mark - Propertys

- (NSMutableDictionary *)requestManager
{
    if (_requestManager == nil) {
        _requestManager = [[NSMutableDictionary alloc] init];
    }
    return _requestManager;
}

@end
