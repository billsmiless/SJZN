//
//  DSContentButtonCtrl.m
//  DSComponents
//
//  Created by cgw on 2019/3/14.
//  Copyright © 2019 bill. All rights reserved.
//

#import "DSContentButtonCtrl.h"
#import "DSContentButton.h"

@interface DSContentButtonCtrl ()

@end

@implementation DSContentButtonCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    DSContentButton *cb = [[DSContentButton alloc] initWithCornerRadius:5.0 borderWidth:1.0 borderColor:[UIColor blueColor]];
    cb.frame = CGRectMake(150, 200, 130, 45);
    cb.backgroundColor = [UIColor cyanColor];
    cb.contentRect = CGRectMake(-20, 20, 100, 40);
//
    CGSize size = cb.contentRect.size;
    cb.titleRect = CGRectMake(0, (size.height-20)/2, 50, 20);
    cb.imageRect = CGRectMake(size.width-40, (size.height-40)/2, 40, 40);

    cb.contentView.backgroundColor = [UIColor redColor];
    
    [cb setTitle:@"Suresfdsfsdfsfsafsafsafsafsafsafsafsafsafsafsafsafs" forState:UIControlStateNormal];
    [cb setImage:[UIImage imageNamed:@"06"] forState:UIControlStateNormal];
    
    [self.view addSubview:cb];
    
//    [cb setNeedsLayout];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
