//
//  DSDataProcess.m
//  DSComponents
//
//  Created by cgw on 2019/3/5.
//  Copyright © 2019 bill. All rights reserved.
//

#import "DSDataProcess.h"
#import "DSApiManager.h"
#import "DSServerUrlManager.h"

@implementation DSDataProcess

+ (DSDataProcess *)sharedDataProcess{
    static DSDataProcess *dp = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dp = [DSDataProcess new];
    });
    return dp;
}

- (void)test{
    [self requestGetWithCaller:self name:@"publishDetailsPool/getTags" complete:^(NSDictionary *dataDic, NSError *err) {
        NSLog(@"SUCCESS");
    }];
}
#pragma mark - Base
/**
 无参数请求
 
 @param caller 调用者
 @param name 接口名
 @param complete 回调
 */
- (void)requestWithCaller:(NSObject* _Nonnull)caller name:(NSString* _Nonnull)name complete:(void(^)(NSDictionary *dataDic, NSError *err))complete{
    [self baseRequestWithCaller:caller name:name parameters:nil  parametersCanNull:YES isAnalysisData:YES complete:complete isSync:NO isGet:NO];
}

/**
 带有参数的请求
 
 @param caller 调用者
 @param name 接口名
 @param para 参数
 @param complete 回调
 */
- (void)requestWithCaller:( NSObject* _Nonnull )caller name:( NSString* _Nonnull )name parameters:(NSDictionary* _Nonnull )para complete:(void(^)(NSDictionary *dataDic, NSError *err))complete{
    [self baseRequestWithCaller:caller name:name parameters:para parametersCanNull:NO isAnalysisData:YES complete:complete isSync:NO isGet:NO];
}

- (void)requestGetWithCaller:( NSObject* _Nonnull )caller name:( NSString* _Nonnull )name complete:(void(^)(NSDictionary *dataDic, NSError *err))complete{
    [self baseRequestWithCaller:caller name:name parameters:nil parametersCanNull:YES isAnalysisData:YES complete:complete isSync:NO isGet:YES];
}

- (void)extracted:(NSObject *)caller complete:(void (^)(NSDictionary *, NSError *))complete isGet:(BOOL)isGet isSync:(BOOL)isSync name:(NSString *)name para:(NSDictionary *)para parametersCanNull:(BOOL)parametersCanNull isAnalisisData:(BOOL)isAnalisisData {
    NSString *serverUrl = nil;
    if( name.length ){
        serverUrl = [ServerUrlApi stringByAppendingString:name];
    }
    [[DSApiManager sharedInstance] requestDataWithUrl:serverUrl parameters:para parameterCanNull:parametersCanNull caller:caller isGet:isGet configRequest:nil complete:^(NSData *data, NSError *err){
        if( complete ){
            if( err ){
                complete(nil,err);
            }else{
                
                NSError *resultErr = nil;
                NSDictionary *tempData = (NSDictionary*)data;
                if( isAnalisisData ){
                    tempData = [self dataWithResponseData:data resultErr:&resultErr];
                }
                complete(tempData,resultErr);
            }
        }
    }];
}

- (void)baseRequestWithCaller:(NSObject*)caller name:(NSString*)name parameters:(NSDictionary*)para parametersCanNull:(BOOL)parametersCanNull isAnalysisData:(BOOL)isAnalysisData complete:(void(^)(NSDictionary *dataDic, NSError *err))complete isSync:(BOOL)isSync isGet:(BOOL)isGet{
    
    //    NSLog(@"\n==================================\n\nRequest Parameters: \n\n %@\n\n==================================", para);
    [self extracted:caller complete:complete isGet:isGet isSync:isSync name:name para:para parametersCanNull:parametersCanNull isAnalisisData:isAnalysisData];
}

#pragma mark __ErrorAlynasis

- (NSDictionary*)dataWithResponseData:(NSData*)data resultErr:(NSError**)resultErr{
    NSError *jsonErr = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonErr];
    NSString *errMsg = @"数据格式不正确";
    NSInteger errCode = -1;//KErrorCodeDefault;
    if( jsonErr ==nil ){
        if( [dic isKindOfClass:[NSDictionary class]] ){
            return dic;
        }
//            NSString *code = [self formatObjectToString:dic[@"code"]];
//            if( code.integerValue == HttpCodeSuccess ){
//                //请求数据成功，开始解析数据
//                NSDictionary *resultDic = dic[@"data"];
//                //                resultDic = [resultDic xw_defaultValue:@{@"0":@0}];
//                //                if( [resultDic isKindOfClass:[NSDictionary class]] )
//                //                    return resultDic;
//                return resultDic;
//            }else{
//                errMsg = [dic[@"msg"] xw_defaultValue:@""];
//                errCode = ((NSNumber*)([dic[@"code"] xw_defaultValue:@(errCode)])).integerValue;
//            }
//        }
    }

//    *resultErr = [KError errorWithCode:errCode msg:errMsg];
    return nil;
}

- (NSString*)formatObjectToString:(NSObject*)obj{
    if( [obj isKindOfClass:[NSString class]] ){
        return (NSString*)obj;
    }else if( [obj isKindOfClass:[NSNumber class]] ){
        return ((NSNumber*)obj).stringValue;
    }
    
    return @"";
}


@end
