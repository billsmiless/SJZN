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

/**
 创建实例

 @param cellClass 列表的cell的类，必须是UICollectionViewCell的子类
 @param cellSize cell的大小
 @param contentEdgeInsets 内容的边距，只有左右有效果，上下无效果
 @param interCellSpace cell之间的间距
 @return 实例
 */
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
- (void)horizontalTableView:(DSHorizontalTableView*)htView setupCell:(UICollectionViewCell*)cell atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
