//
//  NSObject+dsNetworking.m
//  WKDemo
//
//  Created by cgw on 2018/9/5.
//  Copyright © 2018 cgw. All rights reserved.
//

#import "NSObject+DSNetworking.h"

@implementation NSObject (DSNetworking)

- (id)ds_defaultValue:(id)defaultData
{
    if (![defaultData isKindOfClass:[self class]]) {
        return defaultData;
    }
    
    if ([self ds_isEmptyObject]) {
        return defaultData;
    }
    
    return self;
}

- (BOOL)ds_isEmptyObject
{
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self length] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)self count] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        if ([(NSDictionary *)self count] == 0) {
            return YES;
        }
    }
    
    return NO;
}
@end
