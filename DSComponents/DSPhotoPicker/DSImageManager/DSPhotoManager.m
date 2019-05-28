//
//  DSPhotoManager.m
//  DSComponents
//
//  Created by cgw on 2019/3/21.
//  Copyright © 2019 bill. All rights reserved.
//

#import "DSPhotoManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "DSAlbumModel.h"
#import "DSPhotoModel.h"

@implementation DSPhotoManager

- (NSArray<DSPhotoModel *> *)getPhotoDatas{
    
    return nil;
}

#pragma mark - Get Assets

/// Get Assets 获得照片数组
//- (void)getAssetsFromFetchResult:(id)result allowPickingVideo:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(NSArray<TZAssetModel *> *))completion {
//    NSMutableArray *photoArr = [NSMutableArray array];
//    if ([result isKindOfClass:[PHFetchResult class]]) {
//        PHFetchResult *fetchResult = (PHFetchResult *)result;
//        [fetchResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            TZAssetModel *model = [self assetModelWithAsset:obj allowPickingVideo:allowPickingVideo allowPickingImage:allowPickingImage];
//            if (model) {
//                [photoArr addObject:model];
//            }
//        }];
//        if (completion) completion(photoArr);
//    }
//}

- (DSPhotoModel *)assetModelWithAsset:(PHAsset*)asset allowPickingVideo:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage {
    DSPhotoModel *model;
    DSAssetMediaType type = DSAssetMediaTypeImage;
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = (PHAsset *)asset;
        if (phAsset.mediaType == PHAssetMediaTypeVideo)      type = DSAssetMediaTypeVideo;
        else if (phAsset.mediaType == PHAssetMediaTypeAudio) type = DSAssetMediaTypeAudio;
        else if (phAsset.mediaType == PHAssetMediaTypeImage) {
//            if (iOS9_1Later) {
//                // if (asset.mediaSubtypes == PHAssetMediaSubtypePhotoLive) type = TZAssetModelMediaTypeLivePhoto;
//            }
            // Gif
            if ([[phAsset valueForKey:@"filename"] hasSuffix:@"GIF"]) {
                type = DSAssetMediaTypeGif;
            }
        }
        if (!allowPickingVideo && type == DSAssetMediaTypeVideo) return nil;
        if (!allowPickingImage && type == DSAssetMediaTypeImage) return nil;
        if (!allowPickingImage && type == DSAssetMediaTypeImage) return nil;
        
//        if (self.hideWhenCanNotSelect) {
//            // 过滤掉尺寸不满足要求的图片
//            if (![self isPhotoSelectableWithAsset:phAsset]) {
//                return nil;
//            }
//        }
//        NSString *timeLength = type == DSAssetMediaTypeVideo ? [NSString stringWithFormat:@"%0.0f",phAsset.duration] : @"";
//        timeLength = [self getNewTimeFromDurationSecond:timeLength.integerValue];
//        model = [TZAssetModel modelWithAsset:asset type:type timeLength:timeLength];
    }
    return model;
}

- (DSAlbumModel*)getAlbumDatas{
    BOOL allowPickingVideo = YES;
    BOOL allowPickingImage = YES;
    
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    if (!allowPickingVideo){
        option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    }
    if (!allowPickingImage){
        option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld",
                            PHAssetMediaTypeVideo];
    }
    
    //    BOOL sortAscendingByModificationDate = YES;
    //    if (!sortAscendingByModificationDate) {
    //        option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:self.sortAscendingByModificationDate]];
    //    }
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in smartAlbums) {
        // 有可能是PHCollectionList类的的对象，过滤掉
        if (![collection isKindOfClass:[PHAssetCollection class]]) continue;
        if ([self isCameraRollAlbum:collection.localizedTitle]) {
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:option];
            return nil;
//            return [DSAlbumModel albumModelWithFecthResult:fetchResult];
        }
    }
    
    return nil;
}

#pragma mark - Private
- (BOOL)isCameraRollAlbum:(NSString *)albumName {
    NSString *versionStr = [[UIDevice currentDevice].systemVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (versionStr.length <= 1) {
        versionStr = [versionStr stringByAppendingString:@"00"];
    } else if (versionStr.length <= 2) {
        versionStr = [versionStr stringByAppendingString:@"0"];
    }
    CGFloat version = versionStr.floatValue;
    // 目前已知8.0.0 - 8.0.2系统，拍照后的图片会保存在最近添加中
    if (version >= 800 && version <= 802) {
        return [albumName isEqualToString:@"最近添加"] || [albumName isEqualToString:@"Recently Added"];
    } else {
        return [albumName isEqualToString:@"Camera Roll"] || [albumName isEqualToString:@"相机胶卷"] || [albumName isEqualToString:@"所有照片"] || [albumName isEqualToString:@"All Photos"];
    }
}

//- (TZAlbumModel *)modelWithResult:(id)result name:(NSString *)name{
//    TZAlbumModel *model = [[TZAlbumModel alloc] init];
//    model.result = result;
//    model.name = name;
//    if ([result isKindOfClass:[PHFetchResult class]]) {
//        PHFetchResult *fetchResult = (PHFetchResult *)result;
//        model.count = fetchResult.count;
//    } else if ([result isKindOfClass:[ALAssetsGroup class]]) {
//        ALAssetsGroup *group = (ALAssetsGroup *)result;
//        model.count = [group numberOfAssets];
//    }
//    return model;
//}

@end
