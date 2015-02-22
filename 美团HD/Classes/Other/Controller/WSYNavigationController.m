//
//  WSYNavigationController.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/16.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "WSYNavigationController.h"

@interface WSYNavigationController ()

@end

@implementation WSYNavigationController

+ (void)initialize {
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar_normal"] forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 普通文字颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = WSYColor(21, 188, 173);
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    // 不可使用文字颜色
    NSMutableDictionary *disableattrs = [NSMutableDictionary dictionary];
    disableattrs[NSForegroundColorAttributeName] = WSYColor(100, 100, 100);
    [item setTitleTextAttributes:disableattrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
