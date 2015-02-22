//
//  HomeViewController.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/16.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "HomeTopItem.h"
#import "DealCell.h"

#import "HomeViewController.h"
#import "SortViewController.h"
#import "CategoryViewController.h"
#import "DistrictViewController.h"
#import "DetailViewController.h"
#import "CollectViewController.h"
#import "WSYNavigationController.h"
#import "HistoryViewController.h"
#import "SearchViewController.h"

#import "Sort.h"
#import "Categories.h"
#import "City.h"
#import "Districts.h"

#import "DPAPI.h"
#import "FindDealsResult.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "MBProgressHUD+MJ.h"
#import <PureLayout.h>
#import "DataTool.h"
#import "AwesomeMenu.h"

@interface HomeViewController () <AwesomeMenuDelegate>
@property (nonatomic, strong) UIBarButtonItem *categoryItem;
@property (nonatomic, strong) UIBarButtonItem *districtItem;
@property (nonatomic, strong) UIBarButtonItem *sortItem;
/** 记录一些当前的数据 */
/** 当前的城市 */
@property (nonatomic, strong) City *currentCity;
/** 当前的区域 */
@property (nonatomic, strong) Districts *currentDistricts;
/** 当前的排序 */
@property (nonatomic, strong) Sort *currentSort;
/** 当前的类别 */
@property (nonatomic, strong) Categories *currentCategories;
/** 当前的类别名字 */
@property (nonatomic, copy) NSString *currentCategoryName;
/** 当前的地区名字 */
@property (nonatomic, copy) NSString *currentRegionName;
/** 当前的页码 */
@property (nonatomic, assign) int page;
/** 当前的请求 */
@property (nonatomic, weak) DPRequest *currentRequest;
/** 当前的返回结果 */
@property (nonatomic, strong) FindDealsResult *result;
@end

@implementation HomeViewController
#pragma mark - 实现父类方法
- (NSString *)noDataImageName {
    return @"icon_deals_empty";
}

#pragma mark - 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏左边
    [self setupNaviLeft];
    // 设置导航栏右边
    [self setupNaviRight];
    // 监听通知
    [self setupNotes];
    // 增加刷新功能
    [self setupRefresh];
    // 增加环形菜单
    [self setupAwesomeMenu];
}

- (void)setupAwesomeMenu {
    UIImage *itemBackground = [UIImage imageNamed:@"bg_pathMenu_black_normal"];
    // 0.开始按钮
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_pathMenu_background_normal"] highlightedImage:[UIImage imageNamed:@"icon_pathMenu_background_highlighted"] ContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"]];
    // 1.个人信息
    AwesomeMenuItem *personalItem = [[AwesomeMenuItem alloc] initWithImage:itemBackground highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_mine_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_mine_highlighted"]];
    // 2.收藏
    AwesomeMenuItem *collectItem = [[AwesomeMenuItem alloc] initWithImage:itemBackground highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"]];
    // 3.历史记录
    AwesomeMenuItem *historyItem = [[AwesomeMenuItem alloc] initWithImage:itemBackground highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_scan_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_scan_highlighted"]];
    // 4.设置
    AwesomeMenuItem *settingItem = [[AwesomeMenuItem alloc] initWithImage:itemBackground highlightedImage:nil ContentImage:[UIImage imageNamed:@"icon_pathMenu_more_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_more_highlighted"]];
    
    NSArray *items = @[personalItem, collectItem, historyItem, settingItem];
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:CGRectZero startItem:startItem optionMenus:items];
    menu.delegate = self;
    menu.alpha = 0.5;
    [self.view addSubview:menu];
    [menu autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [menu autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [menu autoSetDimensionsToSize:CGSizeMake(200, 200)];
    menu.startPoint = CGPointMake(40, 160);
    menu.menuWholeAngle = M_PI_2;
}

- (void)setupRefresh {
    [self.collectionView addHeaderWithTarget:self action:@selector(loadNewDeals)];
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreDeals)];
    self.collectionView.footerHidden = YES;
    self.collectionView.headerHidden = YES;
    self.collectionView.headerRefreshingText = @"本汪正在帮你刷新";
    self.collectionView.footerRefreshingText = @"本汪正在帮你刷新";
#warning TODO 默认使用北京
    self.currentCity = [DataTool cityWithName:@"北京"];
    [self.collectionView headerBeginRefreshing];

}
/**
 *  导航栏左边
 */
- (void)setupNaviLeft {
    // logo
    UIBarButtonItem *logoItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStylePlain target:nil action:nil];
    logoItem.enabled = NO;
    // 类别
    HomeTopItem *categoryItem = [HomeTopItem item];
    [categoryItem setIcon:@"icon_category_-1" highIcon:@"icon_category_highlighted_-1"];
    categoryItem.title = @"全部分类";
    categoryItem.subtitle = nil;
    categoryItem.backgroundColor = [UIColor clearColor];
    [categoryItem addTarget:self action:@selector(categoryClick)];
    self.categoryItem = [[UIBarButtonItem alloc] initWithCustomView:categoryItem];
    // 区域
    HomeTopItem *districtItem = [HomeTopItem item];
    [districtItem setIcon:@"icon_district" highIcon:@"icon_district_highlighted"];
    districtItem.title = @"北京 - 全部";
    districtItem.subtitle = nil;
    districtItem.backgroundColor = [UIColor clearColor];
    [districtItem addTarget:self action:@selector(districtClick)];
    self.districtItem = [[UIBarButtonItem alloc] initWithCustomView:districtItem];
    // 排序
    HomeTopItem *sortItem = [HomeTopItem item];
    [sortItem setIcon:@"icon_sort" highIcon:@"icon_sort_highlighted"];
    sortItem.title = @"排序";
    sortItem.subtitle = @"默认排序";
    sortItem.backgroundColor = [UIColor clearColor];
    [sortItem addTarget:self action:@selector(sortClick)];
    self.sortItem = [[UIBarButtonItem alloc] initWithCustomView:sortItem];
    
    self.navigationItem.leftBarButtonItems = @[logoItem, self.categoryItem, self.districtItem, self.sortItem];
}

/**
 *  导航栏右边
 */
- (void)setupNaviRight {
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithImage:@"icon_search" highImage:@"icon_search_highlighted" target:self action:@selector(searchClick)];
    searchItem.customView.width = 50;
    
    UIBarButtonItem *mapItem = [UIBarButtonItem itemWithImage:@"icon_map" highImage:@"icon_map_highlighted" target:self action:@selector(mapClick)];
    mapItem.customView.width = searchItem.customView.width;
    self.navigationItem.rightBarButtonItems = @[mapItem, searchItem];
}

/**
 *  监听通知
 */
- (void)setupNotes {
    [WSYNoteCenter addObserver:self selector:@selector(sortDidChange:) name:SortDidChangeNotification object:nil];
    [WSYNoteCenter addObserver:self selector:@selector(categoryDidChange:) name:CategoryDidChangeNotification object:nil];
    [WSYNoteCenter addObserver:self selector:@selector(cityDidChange:) name:CityDidChangeNotification object:nil];
    [WSYNoteCenter addObserver:self selector:@selector(districtDidChange:) name:DistrictDidChangeNotification object:nil];
}

#pragma mark - <AwesomeMenuDelegate>
- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx {
    switch (idx) {
        case 0: // 个人
            break;
        case 1: {// 收藏
            CollectViewController *collectVC = [[CollectViewController alloc] init];
            WSYNavigationController *navi = [[WSYNavigationController alloc] initWithRootViewController:collectVC];
            [self presentViewController:navi animated:YES completion:nil];
            break;
        }
        case 2: {// 历史
            HistoryViewController *historyVC = [[HistoryViewController alloc] init];
            WSYNavigationController *navi = [[WSYNavigationController alloc] initWithRootViewController:historyVC];
            [self presentViewController:navi animated:YES completion:nil];
            break;
        }
        case 3: // 设置
            break;
    }
    [self awesomeMenuWillAnimateClose:menu];
}

- (void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu {
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_cross_normal"];
    menu.highlightedContentImage = [UIImage imageNamed:@"icon_pathMenu_cross_highlighted"];
    [UIView animateWithDuration:0.5 animations:^{
        menu.alpha = 1.0;
    }];
}

- (void)awesomeMenuWillAnimateClose:(AwesomeMenu *)menu {
    [UIView animateWithDuration:0.5 animations:^{
        menu.alpha = 0.5;
    }];
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_normal"];
    menu.highlightedContentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"];
}

#pragma mark - 通知处理
- (void)sortDidChange:(NSNotification *)noti {
    HomeTopItem *topItem = (HomeTopItem *)self.sortItem.customView;
    self.currentSort = noti.userInfo[CurrentSortKey];
    topItem.subtitle = self.currentSort.label;
    // 发请求给服务器
    [self.collectionView headerBeginRefreshing];
}

- (void)categoryDidChange:(NSNotification *)noti {
    HomeTopItem *topItem = (HomeTopItem *)self.categoryItem.customView;
    self.currentCategories = noti.userInfo[CurrentCategoryKey];
    int subcategoryIndex = [noti.userInfo[CurrentSubcategoryIndexKey] intValue];
    NSString *subcategory = self.currentCategories.subcategories[subcategoryIndex];
    topItem.title = self.currentCategories.name;
    topItem.subtitle = subcategory;
    [topItem setIcon:self.currentCategories.icon highIcon:self.currentCategories.highlighted_icon];
    self.currentCategoryName = subcategory ? subcategory : self.currentCategories.name;
    if ([self.currentCategoryName isEqualToString:@"全部"]) {
        self.currentCategoryName = self.currentCategories.name;
    } else if ([self.currentCategoryName isEqualToString:@"全部分类"]) {
        self.currentCategoryName = nil;
    }
    // 发请求给服务器
    [self.collectionView headerBeginRefreshing];
}

- (void)cityDidChange:(NSNotification *)noti {
    HomeTopItem *topItem = (HomeTopItem *)self.districtItem.customView;
    self.currentCity = noti.userInfo[CurrentCityKey];
    self.currentRegionName = nil;
    topItem.title = [NSString stringWithFormat:@"%@ - 全部", self.currentCity.name];
    // 发请求给服务器
    [self.collectionView headerBeginRefreshing];
}

- (void)districtDidChange:(NSNotification *)noti {
    HomeTopItem *topItem = (HomeTopItem *)self.districtItem.customView;
    self.currentDistricts = noti.userInfo[CurrentDistrictKey];
    int subdistrictIndex = [noti.userInfo[CurrentSubdistrictIndexKey] intValue];
    NSString *subdistrict = self.currentDistricts.subdistricts[subdistrictIndex];
    topItem.title = [NSString stringWithFormat:@"%@ - %@", self.currentCity.name, self.currentDistricts.name];
    topItem.subtitle = subdistrict;
    self.currentRegionName = subdistrict ? subdistrict : self.currentDistricts.name;
    if ([self.currentRegionName isEqualToString:@"全部"]) {
        self.currentRegionName = subdistrict ? self.currentDistricts.name : nil;
    }
    // 发请求给服务器
    [self.collectionView headerBeginRefreshing];
}

#pragma mark - 导航栏点击事件
/** 搜索点击事件 */
- (void)searchClick {
    if (self.currentCity == nil) {
        [MBProgressHUD showError:@"请选择城市后再搜索"];
        return;
    }
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    searchVC.cityName = self.currentCity.name;
    WSYNavigationController *navi = [[WSYNavigationController alloc] initWithRootViewController:searchVC];
    
    [self presentViewController:navi animated:YES completion:nil];
}
/** 地图点击事件 */
- (void)mapClick {
    WSYLog(@"mapClick");
}
/** 分类点击事件 */
- (void)categoryClick {
    CategoryViewController *categoryVC = [[CategoryViewController alloc] init];
    categoryVC.modalPresentationStyle = UIModalPresentationPopover;
    categoryVC.popoverPresentationController.barButtonItem = self.categoryItem;
    [self presentViewController:categoryVC animated:YES completion:nil];
    
}
/** 区域点击事件 */
- (void)districtClick {
    DistrictViewController *districtVC = [[DistrictViewController alloc] init];
    districtVC.modalPresentationStyle = UIModalPresentationPopover;
    districtVC.popoverPresentationController.barButtonItem = self.districtItem;
    districtVC.districts = self.currentCity.districts;
    [self presentViewController:districtVC animated:YES completion:nil];
}
/** 排序点击事件 */
- (void)sortClick {
    SortViewController *sortVC = [[SortViewController alloc] init];
    sortVC.modalPresentationStyle = UIModalPresentationPopover;
    sortVC.popoverPresentationController.barButtonItem = self.sortItem;
    [self presentViewController:sortVC animated:YES completion:nil];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger count = [super collectionView:collectionView numberOfItemsInSection:section];
    // 控制上拉控件的显示和隐藏
    self.collectionView.footerHidden = (count == self.result.total_count);
    return count;
}

- (void)dealloc {
    [WSYNoteCenter removeObserver:self];
    // 清除正在发送的请求
    [self.currentRequest disconnect];
}

#pragma mark - 私有方法
- (void)loadNewDeals {
    if (self.currentCity == nil) return;
    // 清除之前的请求
    [self.currentRequest disconnect];
    [self.collectionView footerEndRefreshing];
    self.collectionView.headerHidden = NO;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 城市
    params[@"city"] = self.currentCity.name;
    // 限制个数
    params[@"limit"] = @(kDealLimit);
    // 区域
    if (self.currentRegionName) params[@"region"] = self.currentRegionName;
    // 类别
    if (self.currentCategoryName) params[@"category"] = self.currentCategoryName;
    // 排序
    if (self.currentSort) params[@"sort"] = @(self.currentSort.value);
    // 页码
    params[@"page"] = @(1);
    self.currentRequest = [[DPAPI sharedInstance] request:@"v1/deal/find_deals" params:params success:^(id json) {
//        WSYLog(@"%@", json);
        self.result = [FindDealsResult objectWithKeyValues:json];
        // 移除旧数据
        [self.deals removeAllObjects];
        // 添加新数据
        [self.deals addObjectsFromArray:self.result.deals];
        // 刷新表格
        [self.collectionView reloadData];
        // 结束刷新动画
        [self.collectionView headerEndRefreshing];
        // 重新记录页码
        self.page = 1;
    } failure:^(NSError *error) {
        WSYLog(@"%@", error);
        [MBProgressHUD showError:@"网络繁忙，请稍后再试"];
        // 结束刷新动画
        [self.collectionView headerEndRefreshing];
    }];
}

- (void)loadMoreDeals {
    if (self.currentCity == nil) return;
    // 清除之前的请求
    [self.currentRequest disconnect];
    [self.collectionView headerEndRefreshing];
    // 页码自增
    int tempPage = self.page;
    tempPage++;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 城市
    params[@"city"] = self.currentCity.name;
    // 限制个数
    params[@"limit"] = @(kDealLimit);
    // 区域
    if (self.currentRegionName) params[@"region"] = self.currentRegionName;
    // 类别
    if (self.currentCategoryName) params[@"category"] = self.currentCategoryName;
    // 排序
    if (self.currentSort) params[@"sort"] = @(self.currentSort.value);
    // 页码
    params[@"page"] = @(tempPage);
    self.currentRequest = [[DPAPI sharedInstance] request:@"v1/deal/find_deals" params:params success:^(id json) {
        self.result = [FindDealsResult objectWithKeyValues:json];
        // 添加新数据
        [self.deals addObjectsFromArray:self.result.deals];
        // 刷新表格
        [self.collectionView reloadData];
        // 结束刷新动画
        [self.collectionView footerEndRefreshing];
        self.page = tempPage;
    } failure:^(NSError *error) {
        WSYLog(@"%@", error);
        [MBProgressHUD showError:@"网络繁忙，请稍后再试"];
        // 结束刷新动画
        [self.collectionView footerEndRefreshing];
    }];
}
@end
