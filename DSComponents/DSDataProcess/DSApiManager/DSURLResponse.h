//
//  DSUrlResponse.h
//  DSComponents
//
//  Created by cgw on 2019/3/5.
//  Copyright © 2019 bill. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DSURLResponseStatus)
{
    DSURLResponseStatusSuccess, //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的DSAPIManager来决定。
    DSURLResponseStatusErrorTimeout,
    DSURLResponseStatusErrorNoNetwork // 默认除了超时以外的错误都是网络错误。
};

@interface DSURLResponse : NSObject

@property (nonatomic, assign, readonly) DSURLResponseStatus status;
@property (nonatomic, assign, readonly) NSInteger requestId;
@property (nonatomic, assign, readonly) BOOL isCache;
@property (nonatomic, strong, readonly) NSError *error;

@property (nonatomic, copy, readonly) NSString *contentString;
@property (nonatomic, copy, readonly) id content;
@property (nonatomic, copy, readonly) NSURLRequest *request;
@property (nonatomic, copy, readonly) NSData *responseData;
@property (nonatomic, copy) NSDictionary *requestParams;


- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData status:(DSURLResponseStatus)status;
- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error;

// 使用initWithData的response，它的isCache是YES，上面两个函数生成的response的isCache是NO
- (instancetype)initWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
