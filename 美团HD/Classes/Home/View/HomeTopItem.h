//
//  HomeTopItem.h
//  美团HD
//
//  Created by wangshiyu13 on 15/2/16.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTopItem : UIView
+ (instancetype)item;

- (void)addTarget:(id)target action:(SEL)action;

- (void)setTitle:(NSString *)title;
- (void)setSubtitle:(NSString *)subtitle;
- (void)setIcon:(NSString *)icon highIcon:(NSString *)highIcon;
@end
