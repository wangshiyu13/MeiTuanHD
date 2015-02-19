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
@property (nonatomic, strong) NSMutableArray *resultNames;
@end

@implementation CityResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - 懒加载
- (NSMutableArray *)resultNames {
    if (_resultNames == nil) {
        _resultNames = [[NSMutableArray alloc] init];
    }
    return _resultNames;
}

- (void)setSearchText:(NSString *)searchText {
    if (searchText.length == 0) return;
    
    _searchText = [[searchText copy] lowercaseString];
    
    // 清除旧数据
    [self.resultNames removeAllObjects];
    
    // 根据搜索条件搜索城市
    NSArray *cities = [DataTool cities];
    for (City *city in cities) {
        if ([city.name containsString:searchText]) { // 名字中包含搜索条件
            [self.resultNames addObject:city.name];
        } else if ([city.pinYin containsString:searchText]) { // 拼音包含了搜索条件
            [self.resultNames addObject:city.name];
        } else if ([city.pinYinHead containsString:searchText]) {  // 拼音声母包含了搜索条件
            [self.resultNames addObject:city.name];
        }
    }
    
    // 过滤器
    
    
    // 刷新表格
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultNames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultName"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"resultName"];
    }
    cell.textLabel.text = self.resultNames[indexPath.row];
    return cell;
}

#pragma mark - 代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"共有%zd个搜索结果", self.resultNames.count];
}
@end
