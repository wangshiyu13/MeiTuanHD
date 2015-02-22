//
//  CityResultController.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/18.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "CityResultController.h"
#import "DataTool.h"
#import "City.h"
@interface CityResultController ()
@property (nonatomic, strong) NSArray *resultCities;
@end

@implementation CityResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setSearchText:(NSString *)searchText {
    if (searchText.length == 0) return;
    
    _searchText = [searchText copy];
    searchText = searchText.lowercaseString;
    // 根据搜索条件搜索城市
    NSArray *cities = [DataTool cities];
    
    // 过滤器
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains %@ or pinYin contains %@ or pinYinHead contains %@", searchText, searchText, searchText];
    self.resultCities = [cities filteredArrayUsingPredicate:predicate];
    
    // 刷新表格
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultCities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultName"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"resultName"];
    }
    cell.textLabel.text = [self.resultCities[indexPath.row] name];
    return cell;
}

#pragma mark - 代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"共有%zd个搜索结果", self.resultCities.count];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 销毁
    [self dismissViewControllerAnimated:YES completion:nil];
    // 根据城市名字拿到城市模型
    City *city = self.resultCities[indexPath.row];
    // 发出通知
    [WSYNoteCenter postNotificationName:CityDidChangeNotification object:nil userInfo:@{CurrentCityKey : city}];
}

@end
