//
//  LocalViewController.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/22.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "LocalViewController.h"

#import "Deal.h"
#import "DealTool.h"
#import "UIBarButtonItem+Extension.h"
#import <PureLayout.h>

static NSString * const Edit = @"编辑";
static NSString * const Done = @"完成";
/** 给文字前后加两个空格 */
#define LargeText(text) [NSString stringWithFormat:@"  %@  ", text]

@interface LocalViewController ()
/** 左边所有的item */
@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, strong) UIBarButtonItem *selectAllItem;
@property (nonatomic, strong) UIBarButtonItem *unselectAllItem;
@property (nonatomic, strong) UIBarButtonItem *deleteItem;
@end

@implementation LocalViewController
#pragma mark - 懒加载
- (UIBarButtonItem *)backItem {
    if (_backItem == nil) {
        _backItem = [UIBarButtonItem itemWithImage:@"icon_back" highImage:@"icon_back_highlighted" target:self action:@selector(back)];
    }
    return _backItem;
}
- (UIBarButtonItem *)selectAllItem {
    if (_selectAllItem == nil) {
        _selectAllItem = [[UIBarButtonItem alloc] initWithTitle:LargeText(@"全选") style:UIBarButtonItemStyleDone target:self action:@selector(selectAll)];
    }
    return _selectAllItem;
}
- (UIBarButtonItem *)unselectAllItem {
    if (_unselectAllItem == nil) {
        _unselectAllItem = [[UIBarButtonItem alloc] initWithTitle:LargeText(@"全不选") style:UIBarButtonItemStyleDone target:self action:@selector(unselectAll)];
    }
    return _unselectAllItem;
}
- (UIBarButtonItem *)deleteItem {
    if (_deleteItem == nil) {
        _deleteItem = [[UIBarButtonItem alloc] initWithTitle:LargeText(@"删除") style:UIBarButtonItemStyleDone target:self action:@selector(delete)];
        _deleteItem.enabled = NO;
    }
    return _deleteItem;
}

#pragma mark - 生命周期方法
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.deals removeAllObjects];
    [self.deals addObjectsFromArray:[self totalDeals]];
    [self.collectionView reloadData];
    // 清空模型的状态
    for (Deal *deal in self.deals) {
        deal.editing = NO;
        deal.checked = NO;
    }
    self.navigationItem.rightBarButtonItem.enabled = (self.deals.count > 0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setupNavi];
    // 监听通知
    [WSYNoteCenter addObserver:self selector:@selector(coverClick) name:CellCoverDidClickNotification object:nil];
}

- (void)dealloc {
    [WSYNoteCenter removeObserver:self];
}

#pragma mark - 通知方法
- (void)coverClick {
    NSUInteger count = [self.deals filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"checked == YES"]].count;
    if (count) {
        NSString *deleteStr = [NSString stringWithFormat:@"删除(%zd)", count];
        self.deleteItem.title = LargeText(deleteStr);
        self.deleteItem.enabled = YES;
    } else {
        self.deleteItem.title = LargeText(@"删除");
        self.deleteItem.enabled = NO;
    }
}

#pragma mark - 初始化方法
- (void)setupNavi {
    self.navigationItem.leftBarButtonItem = self.backItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:Edit style:UIBarButtonItemStyleDone target:self action:@selector(edit)];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)edit {
    NSString *title = self.navigationItem.rightBarButtonItem.title;
    if ([title isEqualToString:Edit]) { // 进入编辑模式
        self.navigationItem.rightBarButtonItem.title = Done;
        self.navigationItem.leftBarButtonItems = @[self.backItem, self.selectAllItem, self.unselectAllItem, self.deleteItem];
        for (Deal *deal in self.deals) {
            deal.editing = YES;
        }
        [self.collectionView reloadData];
    } else { // 结束编辑模式
        self.navigationItem.rightBarButtonItem.title = Edit;
        self.navigationItem.leftBarButtonItems = @[self.backItem];
        for (Deal *deal in self.deals) {
            deal.editing = NO;
            deal.checked = NO;
        }
        // 如果结束编辑模式时没有收藏了就禁止使用编辑按钮
        self.navigationItem.rightBarButtonItem.enabled = (self.deals.count > 0);
        [self.collectionView reloadData];
    }
}

- (void)selectAll {
    for (Deal *deal in self.deals) {
        deal.checked = YES;
    }
    [self.collectionView reloadData];
    [self coverClick];
}

- (void)unselectAll {
    for (Deal *deal in self.deals) {
        deal.checked = NO;
    }
    [self.collectionView reloadData];
    [self coverClick];
}

- (void)delete {
    NSArray *deletedArray = [self.deals filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"checked == YES"]];
    // 删除沙盒中的数据
    [self deleteLocalDeals:deletedArray];
    
    [self.deals removeObjectsInArray:deletedArray];
    [self.collectionView reloadData];
    [self coverClick];
    [self edit];
}

@end
