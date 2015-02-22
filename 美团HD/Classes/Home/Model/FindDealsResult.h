//
//  FindDealsResult.h
//  美团HD
//
//  Created by wangshiyu13 on 15/2/20.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindDealsResult : NSObject
@property (nonatomic, assign) int total_count;
@property (nonatomic, strong) NSArray *deals;
@end
