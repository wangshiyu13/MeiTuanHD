//
//  CollectViewController.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/21.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "CollectViewController.h"
#import "DealTool.h"
#import "MBProgressHUD+MJ.h"

@interface CollectViewController ()
@end

@implementation CollectViewController
#pragma mark - 实现父类方法
- (NSString *)noDataImageName {
    return @"icon_collects_empty";
}

- (void)deleteLocalDeals:(NSArray *)deleteDeals {
    [DealTool uncollectDeals:deleteDeals];
    [MBProgressHUD showSuccess:@"收藏已删除"];
}

- (NSArray *)totalDeals {
    return [DealTool collectedDeals];
}

- (NSString *)title {
    return @"我的收藏";
}
@end
