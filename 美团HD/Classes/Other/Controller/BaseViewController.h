//
//  BaseViewController.h
//  美团HD
//
//  Created by wangshiyu13 on 15/2/22.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//  所有团购列表控制器的基类

#import <UIKit/UIKit.h>

@interface BaseViewController : UICollectionViewController
/** 所有团购 */
@property (nonatomic, strong) NSMutableArray *deals;
/** 子类实现这个方法来告诉父类没有数据的图片名 */
- (NSString *)noDataImageName;
@end
