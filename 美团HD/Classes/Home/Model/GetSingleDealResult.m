//
//  GetSingleDealResult.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/21.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "GetSingleDealResult.h"
#import "Deal.h"

@implementation GetSingleDealResult
+ (NSDictionary *)objectClassInArray {
    return @{@"deals" : [Deal class]};
}
@end
