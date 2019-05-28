//
//  DSPhotoCell.h
//  DSComponents
//
//  Created by cgw on 2019/3/21.
//  Copyright © 2019 bill. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DSPhotoModel;
/**
 照片的cell，看了网上大部分库，都叫什么assetCell，至于为什么，始终没弄明白
 */
@interface DSPhotoCell : UICollectionViewCell

@property (nonatomic, strong) DSPhotoModel *model;

@end

NS_ASSUME_NONNULL_END
