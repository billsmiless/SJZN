//
//  DSApiProxy.m
//  DSComponents
//
//  Created by cgw on 2019/3/5.
//  Copyright © 2019 bill. All rights reserved.
//

#import "DSApiProxy.h"
#import "AFNetworking.h"
#import "DSURLResponse.h"

@interface DSApiProxy()

@property (nonatomic, strong) NSMutableDictionary *dispatchTable;

@end

@implementation DSApiProxy

+ (DSApiProxy *)sharedInstance{
    static DSApiProxy *ap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ap = [DSApiProxy new];
    });
    return ap;
}

- (instancetype)init{
    self = [super init];
    if( self ){
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}

/** 这个函数存在的意义在于，如果将来要把AFNetworking换掉，只要修改这个函数的实现即可。 */
- (NSNumber*)callApiWithRequest:(NSURLRequest*)request success:(DSCallback)success fail:(DSCallback)fail{
    
    NSLog(@"\n====================\n\nRequest Start: \n\n %@\n\n====================", request.URL);
    __block NSURLSessionDataTask *dataTask = nil;
    self.manager.completionQueue = dispatch_get_global_queue(0, 0);
    dataTask = [self.manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSNumber *requestID = @([dataTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        NSData *responseData = responseObject;
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        NSLog(@"\n====================\n\nRequest Value: \n\n %@\n\n====================", responseString);
        //        error = [NSError ]
        if (error) {
            //            [CTLogger logDebugInfoWithResponse:httpResponse
            //                                responseString:responseString
            //                                       request:request
            //                                         error:error];
            DSURLResponse *DSResponse = [[DSURLResponse alloc] initWithResponseString:responseString requestId:requestID request:request responseData:responseData error:error];
            fail?fail(DSResponse):nil;
        } else {
            // 检查http response是否成立。
            //            [CTLogger logDebugInfoWithResponse:httpResponse
            //                                responseString:responseString
            //                                       request:request
            //                                         error:NULL];
            DSURLResponse *DSResponse = [[DSURLResponse alloc] initWithResponseString:responseString requestId:requestID request:request responseData:responseData status:DSURLResponseStatusSuccess];
            success?success(DSResponse):nil;
        }
    }];
    
    NSNumber *requestId = @([dataTask taskIdentifier]);
    
    self.dispatchTable[requestId] = dataTask;
    [dataTask resume];

    return requestId;
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    NSURLSessionDataTask *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDs:(NSArray *)requestIDs
{
    for (NSNumber *requestId in requestIDs) {
        [self cancelRequestWithRequestID:requestId];
    }
}

#pragma mark - Getters
- (NSMutableDictionary *)dispatchTable{
    if( !_dispatchTable ){
        _dispatchTable = [NSMutableDictionary new];
    }
    return _dispatchTable;
}

@end
