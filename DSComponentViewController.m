//
//  DSComponentViewController.m
//  DSComponents
//
//  Created by cgw on 2019/2/14.
//  Copyright © 2019 bill. All rights reserved.
//

#import "DSComponentViewController.h"
#import "DSDataProcess.h"
#import "DSContentButton.h"
#import "DSContentButtonCtrl.h"
#import "DSHorizontalTableViewCtrl.h"
#import "DSWebPageViewCtrl.h"
#import "DSSheetSelectView.h"

@interface DSComponentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation DSComponentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    CGSize size = self.view.frame.size;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, size.width, (size.height))];
    _tableView.dataSource = self;
    _tableView.delegate = self;
//    _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:_tableView];

    _datas = @[@"DSDataProcessDemo",@"DSContentButtonDemo",@"DSHorizontalTableView横向列表",@"WebPageDemo",@"DSSheetSelectViewDemo"];
    
    [_tableView reloadData];
}

- (void)handleBtn{
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseId = @"cellreuseid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if( !cell ){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    
    cell.textLabel.text = _datas[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if( indexPath.row == 0 ){
        //网络demo
        [[DSDataProcess sharedDataProcess] test];
    }else if( indexPath.row == 1 ){
        //按钮
        DSContentButtonCtrl *bc = [[DSContentButtonCtrl alloc] init];
        bc.title = @"测试按钮";
        [self.navigationController pushViewController:bc animated:YES];
    }else if( indexPath.row == 2 ){
        //横向列表
        DSHorizontalTableViewCtrl *tc = [DSHorizontalTableViewCtrl new];
        tc.title = @"横向列表";
        [self.navigationController pushViewController:tc animated:YES];
    }else if( indexPath.row == 3 ){
        //wkwebview网页
        DSWebPageViewCtrl *pc = [DSWebPageViewCtrl new];
        pc.pageUrl = @"https://www.jianshu.com";
        pc.title = @"Web";
        
        [self.navigationController pushViewController:pc animated:YES];
    }else if( indexPath.row == 4 ){
        //底部弹出选择的sheet
        NSArray *datas = @[@"一小时",@"一周",@"一个月",@"三个月"];
        [DSSheetSelectView showWithSelectedIndex:0 datas:datas selectedBlock:^(NSInteger index) {
            NSLog(@"%s__%ld", __func__ ,(long)index);
        }];
    }
}

@end

@implementation DSComponentViewController(RootCtrl)

+ (UIViewController *)rootCtrl{
    UINavigationController *naviCtrl = [[UINavigationController alloc] initWithRootViewController:[DSComponentViewController new]];
    
    return naviCtrl;
}

@end
