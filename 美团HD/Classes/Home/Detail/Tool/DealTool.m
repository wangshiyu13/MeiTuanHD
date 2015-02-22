//
//  DealTool.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/21.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "DealTool.h"
#import "Deal.h"
static int const MaxHistoryDealsCount = 30;
#define CollectFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"collect.data"]
#define HistoryFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"history.data"]
@implementation DealTool
static NSMutableArray *_collectedDeals;
static NSMutableArray *_historyDeals;
+(void)initialize {
    _collectedDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:CollectFilePath];
    if (_collectedDeals == nil) {
        _collectedDeals = [NSMutableArray array];
    }
    _historyDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:HistoryFilePath];
    if (_historyDeals == nil) {
        _historyDeals = [NSMutableArray array];
    }
}
#pragma mark - 收藏相关
+ (NSArray *)collectedDeals {
    return _collectedDeals;
}

+ (BOOL)isCollected:(Deal *)deal {
    return [_collectedDeals containsObject:deal];
}

+ (void)collect:(Deal *)deal {
    [_collectedDeals insertObject:deal atIndex:0];
    [NSKeyedArchiver archiveRootObject:_collectedDeals toFile:CollectFilePath];
}

+ (void)uncollect:(Deal *)deal {
    [_collectedDeals removeObject:deal];
    [NSKeyedArchiver archiveRootObject:_collectedDeals toFile:CollectFilePath];
}

+ (void)uncollectDeals:(NSArray *)deals {
    [_collectedDeals removeObjectsInArray:deals];
    [NSKeyedArchiver archiveRootObject:_collectedDeals toFile:CollectFilePath];
}

#pragma mark - 历史相关
+ (NSArray *)historyDeals {
    return _historyDeals;
}

+ (void)addHistoryDeal:(Deal *)deal {
    [_historyDeals removeObject:deal];
    [_historyDeals insertObject:deal atIndex:0];
    if (_historyDeals.count > MaxHistoryDealsCount) {
        [_historyDeals removeLastObject];
    }
    [NSKeyedArchiver archiveRootObject:_historyDeals toFile:HistoryFilePath];
}

+ (void)deleteHistoryDeal:(Deal *)deal {
    [_historyDeals removeObject:deal];
    [NSKeyedArchiver archiveRootObject:_historyDeals toFile:HistoryFilePath];
}

+ (void)deleteHistoryDeals:(NSArray *)deals {
    [_historyDeals removeObjectsInArray:deals];
    [NSKeyedArchiver archiveRootObject:_historyDeals toFile:HistoryFilePath];
}
@end
