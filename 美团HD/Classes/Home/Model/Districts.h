//
//  Districts.h
//  美团HD
//
//  Created by wangshiyu13 on 15/2/17.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Districts : NSObject
/** 区域名称 */
@property (nonatomic, copy) NSString *name;
/** 这个区域的所有子区域 */
@property (nonatomic, strong) NSArray *subdistricts;
@end
