//
//  FindDealsResult.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/20.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "FindDealsResult.h"
#import "Deal.h"
@implementation FindDealsResult
+ (NSDictionary *)objectClassInArray {
    return @{@"deals" : [Deal class]};
}
@end
