//
//  NSObject+DSNetworkingAutoCancel.m
//  WKDemo
//
//  Created by cgw on 2018/9/8.
//  Copyright © 2018 cgw. All rights reserved.
//

#import "NSObject+DSNetworkingAutoCancel.h"
#import "DSNetworkingCancelRequest.h"
#import <objc/runtime.h>

static void* requestTagNum;
@implementation NSObject (DSNetworkingAutoCancel)
- (DSNetworkingCancelRequest *)networkingCancelRequest {
    DSNetworkingCancelRequest *cr = objc_getAssociatedObject(self, @selector(networkingCancelRequest));
    if( cr == nil ){
        cr = [[DSNetworkingCancelRequest alloc] init];
        objc_setAssociatedObject(self, @selector(networkingCancelRequest),cr,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cr;
}

- (void)setRequestTag:(NSNumber*)requestTag{
    objc_setAssociatedObject(self, &requestTagNum, requestTag , OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSNumber*)requestTag{
    return objc_getAssociatedObject(self, &requestTagNum);
}
@end
