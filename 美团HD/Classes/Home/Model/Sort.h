//
//  Sort.h
//  美团HD
//
//  Created by wangshiyu13 on 15/2/16.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sort : NSObject
/** 文字描述 */
@property (nonatomic, copy) NSString *label;
/** 排序类型对应的值 */
@property (nonatomic, assign) int value;
@end
