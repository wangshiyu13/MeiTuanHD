//
//  DealTool.h
//  美团HD
//
//  Created by wangshiyu13 on 15/2/21.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Deal;
@interface DealTool : NSObject
/** 返回用户收藏的所有团购 */
+ (NSArray *)collectedDeals;
/** 判断某个团购是否被收藏 */
+ (BOOL)isCollected:(Deal *)deal;
/** 收藏团购 */
+ (void)collect:(Deal *)deal;
/** 取消收藏团购 */
+ (void)uncollect:(Deal *)deal;
+ (void)uncollectDeals:(NSArray *)deals;

/** 返回用户访问的所有团购 */
+ (NSArray *)historyDeals;
/** 添加最近访问的团购 */
+ (void)addHistoryDeal:(Deal *)deal;
/** 删除最近访问的团购 */
+ (void)deleteHistoryDeal:(Deal *)deal;
+ (void)deleteHistoryDeals:(NSArray *)deals;
@end
