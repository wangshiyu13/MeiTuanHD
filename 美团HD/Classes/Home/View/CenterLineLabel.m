//
//  CenterLineLabel.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/20.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "CenterLineLabel.h"

@implementation CenterLineLabel
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIRectFill(CGRectMake(rect.origin.x, rect.size.height * 0.5 + rect.origin.y, rect.size.width, 0.5));
}

@end
