//
//  DSAlbumModel.h
//  DSComponents
//
//  Created by cgw on 2019/3/21.
//  Copyright © 2019 bill. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DSALBUMMODEL
#define DSALBUMMODEL

typedef NS_ENUM(NSInteger, DSAlbumType){
    DSAlbumTypeA = 0,
    DSAlbumTypeOther
};

#endif

NS_ASSUME_NONNULL_BEGIN

@class PHFetchResult;
@class DSPhotoModel;
@interface DSAlbumModel : NSObject

@property (nonatomic, strong) PHFetchResult *fetchResult;
@property (nonatomic, strong) NSArray<DSPhotoModel*> *photos;
@property (nonatomic, assign) DSAlbumType type;
@property (nonatomic, strong) NSString *name;

+ (DSAlbumModel*)albumModelWithFecthResult:(PHFetchResult*)result name:(NSString*)name;

@end

NS_ASSUME_NONNULL_END
