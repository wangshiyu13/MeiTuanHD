//
//  Deal.h
//  美团HD
//
//  Created by wangshiyu13 on 15/2/20.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Restrictions;
@interface Deal : NSObject <NSCoding>
@property (nonatomic, copy) NSString *deal_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *list_price;
@property (nonatomic, copy) NSString *current_price;
@property (nonatomic, assign) int purchase_count;
@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, copy) NSString *s_image_url;
@property (nonatomic, strong) NSDate *publish_date;
@property (nonatomic, strong) NSDate *purchase_deadline;
@property (nonatomic, copy) NSString *deal_h5_url;
@property (nonatomic, copy) NSString *deal_url;
@property (nonatomic, assign) BOOL is_refundable;

@property (nonatomic, assign, getter=isEditing) BOOL editing;
@property (nonatomic, assign, getter=isChecked) BOOL checked;

@end
