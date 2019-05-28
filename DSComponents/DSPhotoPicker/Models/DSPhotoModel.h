//
//  DSPhotoModel.h
//  DSComponents
//
//  Created by cgw on 2019/3/21.
//  Copyright © 2019 bill. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef DSPHOTOMODEL
#define DSPHOTOMODEL

typedef NS_ENUM(NSInteger, DSAssetMediaType) {
    DSAssetMediaTypeImage = 0,
    DSAssetMediaTypeVideo,
    DSAssetMediaTypeAudio,
    DSAssetMediaTypeGif
};

#endif

@interface DSPhotoModel : NSObject


@end

NS_ASSUME_NONNULL_END
