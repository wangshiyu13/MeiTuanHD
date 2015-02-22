//
//  City.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/19.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "City.h"
#import "Districts.h"
#import <MJExtension.h>

@implementation City
+ (NSDictionary *)objectClassInArray {
    return @{@"districts" : [Districts class]};
}
@end
