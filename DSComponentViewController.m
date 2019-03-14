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

    _datas = @[@"DSDataProcessDemo",@"DSContentButtonDemo",@"Other"];
    
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
    }
}

@end

@implementation DSComponentViewController(RootCtrl)

+ (UIViewController *)rootCtrl{
    UINavigationController *naviCtrl = [[UINavigationController alloc] initWithRootViewController:[DSComponentViewController new]];
    
    return naviCtrl;
}

@end
