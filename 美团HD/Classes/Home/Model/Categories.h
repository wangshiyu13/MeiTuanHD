//
//  Categories.h
//  美团HD
//
//  Created by wangshiyu13 on 15/2/17.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Categories : NSObject
/** 类别名称 */
@property (nonatomic, copy) NSString *name;
/** 类别图标 */
@property (nonatomic, copy) NSString *icon;
/** 类别选中图标 */
@property (nonatomic, copy) NSString *highlighted_icon;
/** 下拉菜单类别小图标 */
@property (nonatomic, copy) NSString *small_icon;
/** 下拉菜单类别选中小图标 */
@property (nonatomic, copy) NSString *small_highlighted_icon;
/** 类别地图图标 */
@property (nonatomic, copy) NSString *map_icon;
/** 子类别 */
@property (nonatomic, strong) NSArray *subcategories;
@end