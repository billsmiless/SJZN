//
//  NSURLRequest+XWNetworking.m
//  WKDemo
//
//  Created by cgw on 2018/9/5.
//  Copyright © 2018 cgw. All rights reserved.
//

#import "NSURLRequest+DSNetworking.h"
#import <objc/runtime.h>

static void *CTNetworkingRequestParams;

@implementation NSURLRequest (XWNetworking)

- (void)setRequestParams:(NSDictionary *)requestParams
{
    objc_setAssociatedObject(self, &CTNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams
{
    return objc_getAssociatedObject(self, &CTNetworkingRequestParams);
}

@end
