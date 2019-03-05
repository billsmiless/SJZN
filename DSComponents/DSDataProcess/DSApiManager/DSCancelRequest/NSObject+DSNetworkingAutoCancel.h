//
//  NSObject+DSNetworkingAutoCancel.h
//  WKDemo
//
//  Created by cgw on 2018/9/8.
//  Copyright © 2018 cgw. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DSNetworkingCancelRequest;
@interface NSObject (DSNetworkingAutoCancel)
@property (nonatomic, strong, readonly) DSNetworkingCancelRequest *networkingCancelRequest;
@property (nonatomic, strong) NSNumber *requestTag;
@end
