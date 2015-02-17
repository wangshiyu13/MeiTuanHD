//
//  DataTool.h
//  美团HD
//
//  Created by wangshiyu13 on 15/2/17.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTool : NSObject
/**
 *  返回所有的排序数据（里面都是Sort模型）
 */
+ (NSArray *)sorts;
/**
 *  返回所有的类别数据（里面都是Categories模型）
 */
+ (NSArray *)categories;
/**
 *  返回所有的城市组数据（里面都是CityGroup模型）
 */
+ (NSArray *)cityGroups;
@end
