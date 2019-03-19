//
//  DSHorizontalTableView.h
//  DSComponents
//
//  Created by cgw on 2019/3/19.
//  Copyright © 2019 bill. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DSHorizontalTableViewDelegate;

/**
 横向滚动列表视图
 */
@interface DSHorizontalTableView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, weak) id<DSHorizontalTableViewDelegate> delegate;

- (id)initWithCellClass:(Class)cellClass
               cellSize:(CGSize)cellSize
      contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
         interCellSpace:(CGFloat)interCellSpace;

- (void)reloadData;

@end

@protocol DSHorizontalTableViewDelegate <NSObject>

@required

/**
 cell的数量

 @param htView tableview
 @return cell的数量
 */
- (NSInteger)numberOfCellsInHorizontalTableView:(DSHorizontalTableView*)htView;

@optional

/**
 设置cell的数据

 @param htView tableview
 @param cell 需要设置的cell实例
 @param index 需要配置的cell的索引
 */
- (void)horizontalTableView:(DSHorizontalTableView*)htView setupCell:(UIView*)cell atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
