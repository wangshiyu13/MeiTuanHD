//
//  HistoryViewController.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/21.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "HistoryViewController.h"
#import "DealTool.h"
#import "MBProgressHUD+MJ.h"

@interface HistoryViewController ()
@end

@implementation HistoryViewController
#pragma mark - 实现父类方法
- (NSString *)noDataImageName {
    return @"icon_latestBrowse_empty";
}

- (void)deleteLocalDeals:(NSArray *)deleteDeals {
    [DealTool deleteHistoryDeals:deleteDeals];
    [MBProgressHUD showSuccess:@"历史记录已删除"];
}

- (NSArray *)totalDeals {
    return [DealTool historyDeals];
}

- (NSString *)title {
    return @"历史记录";
}
@end
