//
//  CityGroup.h
//  美团HD
//
//  Created by wangshiyu13 on 15/2/17.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityGroup : NSObject
/** group名称 */
@property (nonatomic, copy) NSString *title;
/** 这组城市名 */
@property (nonatomic, strong) NSArray *cities;
@end
