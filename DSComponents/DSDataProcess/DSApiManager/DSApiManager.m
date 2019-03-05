//
//  DSApiManager.m
//  DSComponents
//
//  Created by cgw on 2019/3/5.
//  Copyright © 2019 bill. All rights reserved.
//

#import "DSApiManager.h"
#import "DSApiProxy.h"
#import "NSObject+DSNetworking.h"
#import "NSObject+DSNetworkingAutoCancel.h"
#import "DSNetworkingCancelRequest.h"
#import "DSURLResponse.h"

#import "AFNetworking.h"  //用于生成request

NSString *const kNetworkingErrorInfoKey = @"kErrorDefaultKey";


typedef NS_ENUM (NSUInteger, DSAPIManagerErrorType){
    DSAPIManagerErrorTypeDefault,       //没有产生过API请求，这个是manager的默认状态。
    DSAPIManagerErrorTypeSuccess,       //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    DSAPIManagerErrorTypeNoContent,     //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    DSAPIManagerErrorTypeParamsError,   //参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    DSAPIManagerErrorTypeTimeout,       //请求超时。DSAPIProxy设置的是20秒超时，具体超时时间的设置请自己去看DSAPIProxy的相关代码。
    DSAPIManagerErrorTypeNoNetWork,     //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
    DSAPIManagerErrorTypeUnknown        //其他未知
};

@interface DSApiManager()
@property (nonatomic, strong) NSMutableArray *requestIdList;
@end

@implementation DSApiManager

+ (DSApiManager *)sharedInstance{
    
    static DSApiManager *am = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        am = [DSApiManager new];
    });
    
    return am;
}

- (void)requestDataWithUrl:(NSString*)url parameters:(NSDictionary *)parameters parameterCanNull:(BOOL)parametersCanNull caller:(NSObject*)caller isGet:(BOOL)isGet configRequest:(nullable void(^)(NSMutableURLRequest *request))configReqest complete:(void (^)(NSData *, NSError *))complete{
    
    //检查是否有网络
    BOOL isReachable = YES;
    if( !isReachable){
        [self failedOnCallingAPI:nil errorType:(DSAPIManagerErrorTypeNoNetWork) completeHandler:complete];
        return;
    }
    
    NSLog(@"\n==================================\n\nRequest Url: \n\n %@\n\n\n-----------------------------\nRequest Parameters: \n\n %@\n\n ==================================", url, parameters );
    
    //参数不可为空时，验证参数
    if( parametersCanNull ==NO && parameters == nil ){
        [self failedOnCallingAPI:nil errorType:(DSAPIManagerErrorTypeParamsError) completeHandler:complete];
        return;
    }

    NSMutableURLRequest *req = [self requestWithMethod:isGet?@"GET":@"POST" url:url parameters:parameters];
    
    //生成request后，给外部一个配置request的机会
    if( configReqest ){
        configReqest(req);
    }
    
    NSInteger requestId = -1;
    requestId =
    [[DSApiProxy sharedInstance] callApiWithRequest:req success:^(DSURLResponse *response) {
        [self successedOnCallingAPI:response completeHandler:complete];
    } fail:^(DSURLResponse *response) {
        [self failedOnCallingAPI:response errorType:(DSAPIManagerErrorTypeUnknown) completeHandler:complete];
    }].integerValue;
    
    NSNumber *ridNum = @(requestId);
    //给请求id添加一个tag，为了解决一个类可能有多个请求的问题
    ridNum.requestTag = @(caller.requestTag.integerValue);
    [caller.networkingCancelRequest setManager:self requestID:@(requestId)];
    [self.requestIdList addObject:@(requestId)];
}

- (void)cancelRequestWithRequestId:(NSInteger)requestID
{
    [self removeRequestIdWithRequestID:requestID];
    [[DSApiProxy sharedInstance] cancelRequestWithRequestID:@(requestID)];
}

#pragma mark - RequestCallBack
- (void)successedOnCallingAPI:(DSURLResponse *)response completeHandler:(void (^)(NSData *,NSError *))completeHandler
{
    NSError *err = nil;

    //验证服务端是否返回数据。
    if( [[response.contentString ds_defaultValue:@""] isEqualToString:@""]){
        NSString *errMsg = @"数据为空";
        err = [NSError errorWithDomain:@"Network" code:-1 userInfo:@{kNetworkingErrorInfoKey:errMsg}];
    }

    if( completeHandler ){
        completeHandler(response.responseData,err);
    }
}

/**
 请求失败的错误回调
 
 @param response 请求结果
 @param errorType 当未收到请求结果response时，则根据此来判断错误
 @param completeHandler 回调
 */
- (void)failedOnCallingAPI:(DSURLResponse *)response errorType:(DSAPIManagerErrorType)errorType completeHandler:(void (^)(NSData *,NSError *))completeHandler{
    NSString *errMsg = @"遇到错误了";
    
    if( response ){
        if( response.status == DSURLResponseStatusErrorTimeout ){
            errMsg = @"请求超时";
        }else if( response.status == DSURLResponseStatusErrorNoNetwork ){
            errMsg = @"未能连接到服务器";
        }
    }else {
        //未收到resonse，则认为未进行请求，此时错误根据errorType进行判断
        if( errorType == DSAPIManagerErrorTypeNoNetWork ){
            errMsg = @"无网络，请检查网络";
        }else if( errorType == DSAPIManagerErrorTypeParamsError ){
            errMsg = @"参数错误";
        }
    }
    
    NSError *err = [NSError errorWithDomain:@"Network" code:-1 userInfo:@{kNetworkingErrorInfoKey:errMsg}];
    if( completeHandler ){
        completeHandler(nil,err);
    }
}

#pragma mark - Private

- (NSMutableURLRequest*)requestWithMethod:(NSString*)method url:(NSString*)url parameters:(NSDictionary*)para {
    //若想替换掉 AFNetworking，则把本部分替换
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:method URLString:url parameters:para error:nil];
    
    return request;
}

- (void)removeRequestIdWithRequestID:(NSInteger)requestId
{
    NSNumber *requestIDToRemove = nil;
    for (NSNumber *storedRequestId in self.requestIdList) {
        if ([storedRequestId integerValue] == requestId) {
            requestIDToRemove = storedRequestId;
        }
    }
    if (requestIDToRemove) {
        [self.requestIdList removeObject:requestIDToRemove];
    }
}

- (NSMutableArray *)requestIdList{
    if( !_requestIdList ){
        _requestIdList = [NSMutableArray new];
    }
    return _requestIdList;
}

@end
