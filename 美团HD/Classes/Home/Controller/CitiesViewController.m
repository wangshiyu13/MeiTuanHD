//
//  CitiesViewController.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/17.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "CitiesViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "DataTool.h"
#import "CityGroup.h"
@interface CitiesViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"切换城市";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"btn_navigation_close" highImage:@"btn_navigation_close_hl" target:self action:@selector(close)];
    
    self.tableView.sectionIndexColor = [UIColor blackColor];
}

#pragma mark - <UISearchBarDelegate>
/**
 *  当搜索框已经进入编辑状态（键盘已经弹出）
 */
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    // 1.让搜索框背景变为绿色
    searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield_hl"];
    // 2.出现取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    // 3.导航条消失（动画）
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // 4.添加蒙板
    
}
/**
 *  当搜索框已经退吹编辑状态（键盘已经退出）
 */
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    // 1.让搜索框变为灰色
    searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield"];
    // 2.隐藏取消按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    // 3.导航条出现（动画）
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    // 4.移除蒙板
    
}
/**
 *  点击取消按钮
 */
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
}
#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [DataTool cityGroups].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [(CityGroup *)[DataTool cityGroups][section] cities].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"city";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [[DataTool cityGroups][indexPath.section] cities][indexPath.row];
    return cell;
}

#pragma mark - 代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [(CityGroup *)[DataTool cityGroups][section] title];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[DataTool cityGroups] valueForKeyPath:@"title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - dismiss方法
- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
