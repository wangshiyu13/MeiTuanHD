//
//  LocalViewController.h
//  美团HD
//
//  Created by wangshiyu13 on 15/2/22.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//  本地数据控制器

#import "BaseViewController.h"

@interface LocalViewController : BaseViewController
/** 实现该方法来告诉父类如何删除沙盒中的数据 */
- (void)deleteLocalDeals:(NSArray *)deleteDeals;
/** 实现该方法来告诉父类需要显示哪些数据 */
- (NSArray *)totalDeals;
@end
