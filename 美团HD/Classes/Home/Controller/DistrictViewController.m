//
//  DistrictViewController.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/16.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "DistrictViewController.h"
#import "CitiesViewController.h"
#import "WSYNavigationController.h"
@interface DistrictViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@end

@implementation DistrictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = nil;
    return nil;
}

#pragma mark - 私有方法
- (IBAction)changeCity:(id)sender {
    // 销毁当前控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    // 弹出切换城市的控制器
    CitiesViewController *citiesVC = [[CitiesViewController alloc] init];
    WSYNavigationController *navi = [[WSYNavigationController alloc] initWithRootViewController:citiesVC];
    navi.modalPresentationStyle = UIModalPresentationFormSheet;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:navi animated:YES completion:nil];
}
@end
