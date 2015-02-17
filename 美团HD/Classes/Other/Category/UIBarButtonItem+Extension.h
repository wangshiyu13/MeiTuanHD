//
//  UIBarButtonItem+Extension.h
//  美团HD
//
//  Created by wangshiyu13 on 15/2/16.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**
 *  创建一个包含了按钮的item
 *
 *  @param image     普通图片
 *  @param highImage 高亮图片
 *  @param target    点击item后会调用target的action方法
 *  @param action    点击item后调用的方法
 *
 *  @return item
 */
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
