//
//  SortViewController.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/16.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "SortViewController.h"
#import "Sort.h"
#import "DataTool.h"
#import <MJExtension.h>
@interface SortViewController ()
@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *sorts = [DataTool sorts];
    CGFloat margin = 10;
    UIButton *lastBtn = nil;
    for (NSUInteger i = 0; i < sorts.count; ++i) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i + 233;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        lastBtn = button;
        Sort *sort = sorts[i];
        [button setTitle:sort.label forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        // 背景图片
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_selected"] forState:UIControlStateHighlighted];
        button.width = 100;
        button.height = 30;
        button.x = 15;
        button.y = margin + i * (button.height + margin);
    }
    self.preferredContentSize = CGSizeMake(CGRectGetMaxX(lastBtn.frame) + lastBtn.x, CGRectGetMaxY(lastBtn.frame) + margin);
}

- (void)btnClick:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
    [WSYNoteCenter postNotificationName:SortDidChangeNotification object:nil userInfo:@{CurrentSortKey : [DataTool sorts][btn.tag - 233]}];
}
@end
