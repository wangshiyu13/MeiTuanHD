//
//  NSString+Extension.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/20.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (instancetype)dealedPriceString {
    NSString *newString = self;
    NSUInteger dotLoaction = [newString rangeOfString:@"."].location;
    if (dotLoaction != NSNotFound) {
        NSUInteger doCount = newString.length - dotLoaction - 1;
        if (doCount > 2) {
            newString = [newString substringToIndex:dotLoaction + 3];
            if ([newString hasSuffix:@"0"]) {
                newString = [newString substringToIndex:newString.length - 1];
            }
        }
    }
    return newString;
}
@end
