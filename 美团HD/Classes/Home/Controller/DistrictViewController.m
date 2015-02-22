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
#import "DropdownLeftCell.h"
#import "DropdownRightCell.h"
#import "Districts.h"
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
    if (tableView == self.leftTableView) {
        return self.districts.count;
    } else {
        return [self.districts[[self.leftTableView indexPathForSelectedRow].row] subdistricts].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (tableView == self.leftTableView) { // 左边
        cell = [DropdownLeftCell cellWithTableView:tableView];
        Districts *districts = self.districts[indexPath.row];
        cell.textLabel.text = districts.name;
        cell.accessoryType = districts.subdistricts.count ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    } else { // 右边
        cell = [DropdownRightCell cellWithTableView:tableView];
        cell.textLabel.text = [self.districts[[self.leftTableView indexPathForSelectedRow].row] subdistricts][indexPath.row];
    }
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        [self.rightTableView reloadData];
        if ([[self.districts[indexPath.row] subdistricts] count] == 0) {
            [self postNote:self.districts[indexPath.row] subdistrictIndex:nil];
        }
    } else {
        [self postNote:self.districts[[self.leftTableView indexPathForSelectedRow].row] subdistrictIndex:@(indexPath.row)];
    }
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

- (void)postNote:(Districts *)district subdistrictIndex:(NSNumber *)subdistrictIndex {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[CurrentDistrictKey] = district;
    if (subdistrictIndex) {
        userInfo[CurrentSubdistrictIndexKey] = subdistrictIndex;
    }
    [WSYNoteCenter postNotificationName:DistrictDidChangeNotification object:nil userInfo:userInfo];
}
@end
