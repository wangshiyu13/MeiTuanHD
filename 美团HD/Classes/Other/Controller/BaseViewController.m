//
//  BaseViewController.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/22.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "BaseViewController.h"
#import "DetailViewController.h"

#import "DealCell.h"
#import <PureLayout.h>

@interface BaseViewController ()/** 没有团购数据时显示的提醒图片 */
@property (nonatomic, weak) UIImageView *noDataView;
@end

@implementation BaseViewController
static NSString * const reuseIdentifier = @"deal";

#pragma mark - 懒加载
- (UIImageView *)noDataView {
    if (_noDataView == nil) {
        UIImageView *noDataView = [[UIImageView alloc] init];
        noDataView.image = [UIImage imageNamed:[self noDataImageName]];
        noDataView.contentMode = UIViewContentModeCenter;
        [self.view addSubview:noDataView];
        [noDataView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        _noDataView = noDataView;
    }
    return _noDataView;
}

- (NSMutableArray *)deals {
    if (_deals == nil) {
        _deals = [[NSMutableArray alloc] init];
    }
    return _deals;
}

#pragma mark - 监听屏幕旋转
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    layout.itemSize = CGSizeMake(305, 305);
    CGFloat screenW = size.width;
    
    int cols = (screenW == ScreenMaxWH) ? 3 : 2;
    CGFloat allCellW = cols * layout.itemSize.width;
    CGFloat margin = (screenW - allCellW) / (cols + 1);
    layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
}

#pragma mark - 初始化方法
- (instancetype)init {
    return [self initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 根据当前屏幕尺寸进行布局
    [self viewWillTransitionToSize:[UIScreen mainScreen].bounds.size withTransitionCoordinator:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"DealCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = WSYGlobalBG;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger count = self.deals.count;
    self.noDataView.hidden = (count > 0);
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.deal = self.deals[indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.deal = self.deals[indexPath.item];
    [self presentViewController:detailVC animated:YES completion:nil];
}

@end
