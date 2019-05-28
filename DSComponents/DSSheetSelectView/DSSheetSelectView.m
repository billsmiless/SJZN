//
//  DSSheetSelectView.m
//  DSComponents
//
//  Created by cgw on 2019/4/18.
//  Copyright © 2019 bill. All rights reserved.
//

#import "DSSheetSelectView.h"

@interface DSSheetSelectViewTableCell : UITableViewCell
@end

#define DSSheetSelectViewAnimateTime 0.3

@interface DSSheetSelectView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *topView;

@end

@implementation DSSheetSelectView{
    DSSheetSelectViewSelectedBlock _selectedBlock;
}

#pragma mark - Public
+ (DSSheetSelectView *)showWithSelectedIndex:(NSInteger)sIdx datas:(NSArray<NSString *> *)datas selectedBlock:(DSSheetSelectViewSelectedBlock)selectBlock{
    DSSheetSelectView *sv = [DSSheetSelectView new];
    
    [sv showWithSelectedIndex:sIdx datas:datas selectedBlock:selectBlock];
    
    return sv;
}

- (void)hide{
    [UIView animateWithDuration:DSSheetSelectViewAnimateTime animations:^{
        self.center = CGPointMake([self screenSize].width/2, [self screenSize].height+CGRectGetHeight(self.frame)/2);
    } completion:^(BOOL finished) {
        [self.bgBtn removeFromSuperview];
    }];
}

#pragma mark - Private

- (void)showWithSelectedIndex:(NSInteger)sIdx datas:(NSArray<NSString *> *)datas selectedBlock:(DSSheetSelectViewSelectedBlock)selectBlock{
    _selectedBlock = selectBlock;
    _datas = datas;
    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:sIdx inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    //动画展示
    [self show];
}

- (void)show{
    CGFloat cellH = [self cellHeight];
    CGFloat showMaxCount = 5;
    CGFloat count = _datas.count;
    if( _datas.count > showMaxCount ){
        count = showMaxCount;
    }
    CGFloat ih = count*cellH;
    CGFloat iw = [self screenSize].width;
    
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), iw, ih);
    
    //iphonex 底部的高度
    CGFloat xBottomHeight = ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34:0);
    CGFloat selfH = ih+cellH+xBottomHeight;
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgBtn];
    [UIView animateWithDuration:DSSheetSelectViewAnimateTime animations:^{
        self.frame = CGRectMake(0, [self screenSize].height-selfH, iw, selfH);
    }];
}

- (CGFloat)cellHeight{
    return 50;
}

- (CGSize)screenSize{
    return [UIScreen mainScreen].bounds.size;
}

- (UIButton*)buttonWithTitle:(NSString*)title fr:(CGRect)fr{
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithWhite:7/255.0 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithWhite:51/255.0 alpha:1] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(handleTopBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    btn.frame = fr;
    [_topView addSubview:btn];
    return btn;
}

#pragma mark - TouchEvents
- (void)handleTopBtn:(UIButton*)btn{
    if( btn.tag ==0 ){
        //取消
        [self hide];
    }else{
        //确定
        if( _selectedBlock ){
            _selectedBlock(self.tableView.indexPathForSelectedRow.row);
        }
        
        [self hide];
    }
}

#pragma mark - TabelViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseId = @"cellreuseid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if( !cell ){
        cell = [[DSSheetSelectViewTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithWhite:7/255.0 alpha:1];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [UIView new];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:59/255.0 green:127/255.0 blue:224/255.0 alpha:1];
    }
    if( _datas.count > indexPath.row ){
        cell.textLabel.text = _datas[indexPath.row];
    }
    
    return cell;
}

#pragma mark - Getter
- (UIButton *)bgBtn{
    if( !_bgBtn ){
        _bgBtn = [UIButton new];
        _bgBtn.frame = CGRectMake(0, 0, [self screenSize].width, [self screenSize].height);
        _bgBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        [_bgBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [_bgBtn addSubview:self];

        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, [self screenSize].height, 0, 0);
    }
    return _bgBtn;
}

- (UITableView *)tableView {
    if( !_tableView ){
        _tableView = [UITableView new];
        _tableView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        if( @available(iOS 11.0, *)){
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            _tableView.contentInset = UIEdgeInsetsZero;
        }
    }
    
    return _tableView;
}

- (UIView*)topView{
    if( !_topView ){
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor whiteColor];
        CGFloat ih = [self cellHeight];
        _topView.frame = CGRectMake(0, 0, [self screenSize].width, ih);
        [self addSubview:_topView];
        
        //添加按钮
        CGRect fr = CGRectMake(0, 0, 65, ih);
        UIButton *cancleBtn = [self buttonWithTitle:@"取消" fr:fr];
        cancleBtn.tag = 0;
        
        fr.origin.x = ([self screenSize].width-fr.size.width);
        UIButton *sureBtn = [self buttonWithTitle:@"确定" fr:fr];
        sureBtn.tag = 1;
        [sureBtn setTitleColor:[UIColor colorWithRed:59/255.0 green:127/255.0 blue:224/255.0 alpha:1] forState:UIControlStateNormal];
//        R:0.78 G:0.78 B:0.8 A:1
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.8 alpha:1];
        line.frame = CGRectMake(0, ih-0.5, _topView.frame.size.width, 0.5);
        [_topView addSubview:line];
    }
    return _topView;
}

@end

@implementation DSSheetSelectViewTableCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    UIColor *textClor = [UIColor whiteColor];
    if( !selected ){
        textClor = [UIColor colorWithWhite:7/255.0 alpha:1];
    }
    self.textLabel.textColor = textClor;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    for( UIView *line in self.subviews ){
        if( [line isKindOfClass:NSClassFromString(@"_UITableViewCellSeparatorView")] ){
            CGRect fr = line.frame;
            fr.size.width = CGRectGetWidth(self.frame);
            fr.origin.x = 0;
            line.frame = fr;
            
            break;
        }
    }
}

@end
