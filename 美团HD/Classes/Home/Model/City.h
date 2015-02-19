//
//  City.h
//  美团HD
//
//  Created by wangshiyu13 on 15/2/19.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject
/** 城市名称 */
@property (nonatomic, copy) NSString *name;
/** 城市名称的拼音 */
@property (nonatomic, copy) NSString *pinYin;
/** 城市名称的拼音声母 */
@property (nonatomic, copy) NSString *pinYinHead;
@end
