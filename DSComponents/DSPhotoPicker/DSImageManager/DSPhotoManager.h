//
//  DSPhotoManager.h
//  DSComponents
//
//  Created by cgw on 2019/3/21.
//  Copyright © 2019 bill. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DSPhotoModel;
@class DSAlbumModel;
@interface DSPhotoManager : NSObject

- (NSArray<DSPhotoModel*>*)getPhotoDatas;

- (DSAlbumModel*)getAlbumDatas;

@end

NS_ASSUME_NONNULL_END
