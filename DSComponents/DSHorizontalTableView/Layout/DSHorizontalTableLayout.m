//
//  DSHorizontalTableLayout.m
//  DSComponents
//
//  Created by cgw on 2019/3/19.
//  Copyright © 2019 bill. All rights reserved.
//

#import "DSHorizontalTableLayout.h"

@implementation DSHorizontalTableLayout{
    CGFloat _interCellSpace; //cell之间的间距
    CGFloat _contentWidth;   //collectionView的内容宽度
    NSMutableArray<UICollectionViewLayoutAttributes*> *_layoutAttrs; //属性值
}

- (id)initWithInterCellSpace:(double)interCellSpace{
    self = [super init];
    if( self ){
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumInteritemSpacing = interCellSpace;
        _interCellSpace = interCellSpace;
        _contentWidth = 0;
        _layoutAttrs = [NSMutableArray new];
    }
    return self;
}

#pragma mark - ViewMethods

//每一次布局前的准备工作
-(void)prepareLayout
{
    [super prepareLayout];
    
    //计算所有item的属性
    [_layoutAttrs removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<count; i++)
    {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [_layoutAttrs addObject:attrs];
    }
}

//设置collectionView滚动区域
-(CGSize)collectionViewContentSize
{
    return CGSizeMake(_contentWidth, CGRectGetHeight(self.collectionView.frame));
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return _layoutAttrs;
}

//布局每一个属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //创建布局属性
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat iw = self.itemSize.width;
    CGFloat ih = self.itemSize.height;
    CGFloat iy = (CGRectGetHeight(self.collectionView.frame)-ih)/2;
    CGFloat ix = indexPath.row*(iw+_interCellSpace) + self.sectionInset.left;
    
    //设置item的frame
    attr.frame = CGRectMake(ix, iy, iw, ih);
    _contentWidth = (iw+ix+self.sectionInset.right);
    
    return attr;
}

@end
