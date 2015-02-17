//
//  HomeViewController.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/16.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "HomeTopItem.h"

#import "HomeViewController.h"
#import "SortViewController.h"
#import "CategoryViewController.h"
#import "DistrictViewController.h"

#import "Sort.h"
#import "Categories.h"
@interface HomeViewController ()
@property (nonatomic, strong) UIBarButtonItem *categoryItem;
@property (nonatomic, strong) UIBarButtonItem *districtItem;
@property (nonatomic, strong) UIBarButtonItem *sortItem;
@end

@implementation HomeViewController

static NSString * const reuseIdentifier = @"Cell";
#pragma mark - 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = WSYGlobalBG;
    // 设置导航栏左边
    [self setupNaviLeft];
    // 设置导航栏右边
    [self setupNaviRight];
    //监听通知
    [self setupNotes];
}
/**
 *  导航栏左边
 */
- (void)setupNaviLeft {
    // logo
    UIBarButtonItem *logoItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // 类别
    HomeTopItem *categoryItem = [HomeTopItem item];
    [categoryItem setIcon:@"icon_category_-1" highIcon:@"icon_category_highlighted_-1"];
    categoryItem.title = @"全部分类";
    categoryItem.subtitle = nil;
    [categoryItem addTarget:self action:@selector(categoryClick)];
    self.categoryItem = [[UIBarButtonItem alloc] initWithCustomView:categoryItem];
    // 区域
    HomeTopItem *districtItem = [HomeTopItem item];
    [districtItem setIcon:@"icon_district" highIcon:@"icon_district_highlighted"];
    districtItem.title = @"北京";
    districtItem.subtitle = @"全部";
    [districtItem addTarget:self action:@selector(districtClick)];
    self.districtItem = [[UIBarButtonItem alloc] initWithCustomView:districtItem];
    // 排序
    HomeTopItem *sortItem = [HomeTopItem item];
    [sortItem setIcon:@"icon_sort" highIcon:@"icon_sort_highlighted"];
    sortItem.title = @"排序";
    sortItem.subtitle = @"默认排序";
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
}
#pragma mark - 通知处理
- (void)sortDidChange:(NSNotification *)noti {
    [(HomeTopItem *)self.sortItem.customView setSubtitle:[(Sort *)noti.userInfo[CurrentSortKey] label]];
    
}

- (void)categoryDidChange:(NSNotification *)noti {
    [(HomeTopItem *)self.categoryItem.customView setTitle:[noti.userInfo[CurrentCategoryKey] name]];
    if ([noti.userInfo[CurrentCategoryKey] subcategories]) {
        [(HomeTopItem *)self.categoryItem.customView setSubtitle:[noti.userInfo[CurrentCategoryKey] subcategories][[noti.userInfo[CurrentSubcategoryIndexKey] intValue]]];
    } else {
        [(HomeTopItem *)self.categoryItem.customView setSubtitle:@"全部"];
    }
    [(HomeTopItem *)self.categoryItem.customView setIcon:[noti.userInfo[CurrentCategoryKey] icon] highIcon:[noti.userInfo[CurrentCategoryKey] highlighted_icon]];
}
#pragma mark - 导航栏点击事件
- (void)searchClick {
    WSYLog(@"searchClick");
}

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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete method implementation -- Return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete method implementation -- Return the number of items in the section
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}


- (void)dealloc {
    [WSYNoteCenter removeObserver:self];
}
@end
