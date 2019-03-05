//
//  DSApiProxy.h
//  DSComponents
//
//  Created by cgw on 2019/3/5.
//  Copyright © 2019 bill. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DSURLResponse;
@class AFHTTPSessionManager;


#ifndef DSAPIPROXY
#define DSAPIPROXY

typedef NS_ENUM(NSInteger, DSUploadFileType){
    DSUploadFileTypeImage = 0,          //图片
    DSUploadFileTypeVideo,              //视频
    DSUploadFileTypeVoice,              //音频
    DSUploadFileTypeFile                //文件
};

typedef void(^DSCallback)(DSURLResponse *response);

#endif

/**
 Http请求，日志打印
 */
@interface DSApiProxy : NSObject

@property (nonatomic, strong,readonly) AFHTTPSessionManager *manager;

+ (DSApiProxy*)sharedInstance;

//异步调用
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(DSCallback)success fail:(DSCallback)fail;

- (void)cancelRequestWithRequestID:(NSNumber *)requestID;

- (void)cancelRequestWithRequestIDs:(NSArray *)requestIDs;

@end

NS_ASSUME_NONNULL_END
