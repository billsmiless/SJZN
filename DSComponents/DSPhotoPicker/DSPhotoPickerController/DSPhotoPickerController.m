//
//  DSPhotoPickerController.m
//  DSComponents
//
//  Created by cgw on 2019/3/21.
//  Copyright © 2019 bill. All rights reserved.
//

#import "DSPhotoPickerController.h"
#import "DSPhotoCell.h"
#import "TZImageManager.h"

@interface DSPhotoPickerController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) DSPhotoPickerCollectionView *collectionView;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation DSPhotoPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DSPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DSPhotoCell class]) forIndexPath:indexPath];

    if( _datas.count > indexPath.row ){
        cell.model = _datas[indexPath.row];
    }
    
    return cell;
}

#pragma mark - Layout
- (CGRect)getCollectionViewFrame{
    CGFloat iy = 88;
    return CGRectMake(0, iy, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-iy);
}

- (UICollectionViewLayout*)getCollectionViewLayout{
    
    CGFloat cellSpace = 5; //照片间距
    NSInteger columnCount = 4; //列数
    CGFloat photoSize = ([self getCollectionViewFrame].size.width-(columnCount+1)*cellSpace)/columnCount;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(photoSize, photoSize);
    layout.minimumLineSpacing = cellSpace;
    layout.minimumInteritemSpacing = cellSpace;
    layout.sectionInset = UIEdgeInsetsMake(cellSpace, cellSpace, cellSpace, cellSpace);
    
    return layout;
}

#pragma mark - Getter
- (DSPhotoPickerCollectionView *)collectionView{
    if( !_collectionView ){
        CGRect frame = [self getCollectionViewFrame];
        UICollectionViewLayout *layout = [self getCollectionViewLayout];
        
        _collectionView = [[DSPhotoPickerCollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceHorizontal = NO;
        
        [_collectionView registerClass:[DSPhotoCell class] forCellWithReuseIdentifier:NSStringFromClass([DSPhotoCell class])];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

@end

@implementation DSPhotoPickerCollectionView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ( [view isKindOfClass:[UIControl class]]) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}

@end
