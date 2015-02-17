//
//  CategoryViewController.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/16.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "CategoryViewController.h"
#import "Categories.h"
#import "DataTool.h"
#import "DropdownLeftCell.h"
#import "DropdownRightCell.h"
#import <MJExtension.h>

@interface CategoryViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return [DataTool categories].count;
    } else {
        return [[DataTool categories][[self.leftTableView indexPathForSelectedRow].row] subcategories].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (tableView == self.leftTableView) { // 左边
        cell = [DropdownLeftCell cellWithTableView:tableView];
        Categories *category = [DataTool categories][indexPath.row];
        cell.textLabel.text = category.name;
        cell.imageView.image = [UIImage imageNamed:category.small_icon];
        cell.imageView.highlightedImage = [UIImage imageNamed:category.small_highlighted_icon];
        cell.accessoryType = category.subcategories.count ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    } else { // 右边
        cell = [DropdownRightCell cellWithTableView:tableView];
        cell.textLabel.text = [[DataTool categories][[self.leftTableView indexPathForSelectedRow].row] subcategories][indexPath.row];
    }
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        [self.rightTableView reloadData];
        if ([[[DataTool categories][indexPath.row] subcategories] count] == 0) {
            [self postNote:[DataTool categories][indexPath.row] subcategoryIndex:nil];
        }
    } else {
        [self postNote:[DataTool categories][[self.leftTableView indexPathForSelectedRow].row] subcategoryIndex:@(indexPath.row)];
    }
}

#pragma mark - 私有方法
- (void)postNote:(Categories *)category subcategoryIndex:(NSNumber *)subcategoryIndex {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[CurrentCategoryKey] = category;
    if (subcategoryIndex) {
        userInfo[CurrentSubcategoryIndexKey] = subcategoryIndex;
    }
    [WSYNoteCenter postNotificationName:CategoryDidChangeNotification object:nil userInfo:userInfo];
}
@end
