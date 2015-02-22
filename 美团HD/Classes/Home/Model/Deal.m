//
//  Deal.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/20.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "Deal.h"
#import <MJExtension.h>
#import "NSString+Extension.h"
@implementation Deal
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"desc" : @"description",
             @"is_refundable" : @"restrictions.is_refundable"};
}

- (void)setList_price:(NSString *)list_price {
    _list_price = list_price.dealedPriceString;
}

- (void)setCurrent_price:(NSString *)current_price {
    _current_price = current_price.dealedPriceString;
}

- (void)setPublish_date:(NSDate *)publish_date {
#warning 需要加一层判断以防止MJCoding对NSDate属性做二次处理
    if ([publish_date isKindOfClass:[NSString class]]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        _publish_date = [formatter dateFromString:(NSString *)publish_date];
    }
}

- (void)setPurchase_deadline:(NSDate *)purchase_deadline {
    if ([purchase_deadline isKindOfClass:[NSString class]]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        _purchase_deadline = [formatter dateFromString:(NSString *)purchase_deadline];
    }
}

#warning 重写isEqual方法用于修改比较方式
- (BOOL)isEqual:(Deal *)other {
    return [self.deal_id isEqualToString:other.deal_id];
}

#pragma mark - <NSCoding>
MJCodingImplementation
/**
 *  归档时调用，记录哪些属性要存储
 */
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:self.title forKey:@"title"];
//    [aCoder encodeObject:self.deal_id forKey:@"deal_id"];
//}
///**
// *  解档时调用，记录哪些属性需要取出
// */
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super init]) {
//        self.title = [aDecoder decodeObjectForKey:@"title"];
//        self.deal_id = [aDecoder decodeObjectForKey:@"deal_id"];
//    }
//    return self;
//}
@end
