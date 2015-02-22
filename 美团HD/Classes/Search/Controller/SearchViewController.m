//
//  SearchViewController.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/21.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "SearchViewController.h"

#import "DPAPI.h"
#import "FindDealsResult.h"
#import "UIBarButtonItem+Extension.h"

#import <MJRefresh.h>
#import <MJExtension.h>
#import "MBProgressHUD+MJ.h"

@interface SearchViewController () <UISearchBarDelegate>
/** 搜索框 */
@property (nonatomic, weak) UISearchBar *searchBar;
/** 记录一些当前的数据 */
/** 当前的页码 */
@property (nonatomic, assign) int page;
/** 当前的请求 */
@property (nonatomic, weak) DPRequest *currentRequest;
/** 当前的返回结果 */
@property (nonatomic, strong) FindDealsResult *result;

@end

@implementation SearchViewController
#pragma mark - 实现父类方法
- (NSString *)noDataImageName {
    return @"icon_deals_empty";
}

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setupNavi];
    // 增加刷新功能
    [self setupRefresh];
}
/**
 *  刷新功能
 */
- (void)setupRefresh {
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreDeals)];
    self.collectionView.footerHidden = YES;
    self.collectionView.footerRefreshingText = @"本汪正在帮你刷新";
}
/**
 *  导航栏设置
 */
- (void)setupNavi {
    // 返回键
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"icon_back" highImage:@"icon_back_highlighted" target:self action:@selector(back)];
    // 搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 35)];
    self.navigationItem.titleView = titleView;
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.frame = titleView.bounds;
    searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield"];
    [titleView addSubview:searchBar];
    searchBar.delegate = self;
    self.searchBar = searchBar;
}

#pragma mark - <UISearchBarDelegate>
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [MBProgressHUD showMessage:@"正在玩命搜索..."];
    self.page = 0;
    [self loadMoreDeals];
}

#pragma mark - <UICollectionViewDatasource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = [super collectionView:collectionView numberOfItemsInSection:section];
    self.collectionView.footerHidden = (count == self.result.total_count);
    return count;
}

#pragma mark - 导航栏事件处理
- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc {
    // 清除正在发送的请求
    [self.currentRequest disconnect];
}

#pragma mark - 私有方法
- (void)loadMoreDeals {
    // 清除之前的请求
    [self.currentRequest disconnect];
    // 页码自增
    int tempPage = self.page;
    tempPage++;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 城市
    params[@"city"] = self.cityName;
    // 页码
    params[@"page"] = @(tempPage);
    // 搜索条件
    params[@"keyword"] = self.searchBar.text;
    self.currentRequest = [[DPAPI sharedInstance] request:@"v1/deal/find_deals" params:params success:^(id json) {
        self.result = [FindDealsResult objectWithKeyValues:json];
        // 如果是第一页的数据，清除掉以前的数据
        if (tempPage == 1) [self.deals removeAllObjects];
        // 添加新数据
        [self.deals addObjectsFromArray:self.result.deals];
        // 刷新表格
        [self.collectionView reloadData];
        // 结束刷新动画
        [self.collectionView footerEndRefreshing];
        [MBProgressHUD hideHUD];
        self.page = tempPage;
        // 更新搜索条件之后滚动到顶部
        if (tempPage == 1) [self.collectionView setContentOffset:CGPointZero animated:YES];
    } failure:^(NSError *error) {
        WSYLog(@"%@", error);
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络繁忙，请稍后再试"];
        // 结束刷新动画
        [self.collectionView footerEndRefreshing];
    }];
}
@end
