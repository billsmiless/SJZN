//
//  DSAlbumModel.m
//  DSComponents
//
//  Created by cgw on 2019/3/21.
//  Copyright © 2019 bill. All rights reserved.
//

#import "DSAlbumModel.h"
#import <Photos/Photos.h>

@implementation DSAlbumModel

+ (DSAlbumModel *)albumModelWithFecthResult:(PHFetchResult *)result name:(nonnull NSString *)name{
    if( ![result isKindOfClass:[PHFetchResult class]] ) return nil;
    
    DSAlbumModel *album = [DSAlbumModel new];
    album.name = name;
    album.fetchResult = result;
    
    return album;
}

@end
