//
//  DataTool.m
//  美团HD
//
//  Created by wangshiyu13 on 15/2/17.
//  Copyright (c) 2015年 wangshiyu13. All rights reserved.
//

#import "DataTool.h"
#import "Sort.h"
#import "Categories.h"
#import "CityGroup.h"
#import <MJExtension.h>
@implementation DataTool
static NSArray *_sorts;
+ (NSArray *)sorts {
    if (_sorts == nil) {
        _sorts = [Sort objectArrayWithFilename:@"sorts.plist"];
    }
    return _sorts;
}

static NSArray *_categories;
+ (NSArray *)categories {
    if (_categories == nil) {
        _categories = [Categories objectArrayWithFilename:@"categories.plist"];
    }
    return _categories;
}

static NSArray *_cityGroups;
+ (NSArray *)cityGroups {
    if (_cityGroups == nil) {
        _cityGroups = [CityGroup objectArrayWithFilename:@"cityGroups.plist"];
    }
    return _cityGroups;
}
@end
