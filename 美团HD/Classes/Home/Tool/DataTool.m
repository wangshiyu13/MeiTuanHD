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
#import "City.h"
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

static NSArray *_cityNames;
+ (NSArray *)cityNames {
    if (_cityNames == nil) {
        NSMutableArray *cityNames = [NSMutableArray array];
        NSArray *cityGroups = [self cityGroups];
        [cityGroups enumerateObjectsUsingBlock:^(CityGroup *group, NSUInteger idx, BOOL *stop) {
            if (idx == 0) return;
            // 将group.cities中的所有元素添加到cityNames中
            [cityNames addObjectsFromArray:group.cities];
        }];
        _cityNames = cityNames;
    }
    return _cityNames;
}

static NSArray *_cities;
+ (NSArray *)cities {
    if (_cities == nil) {
        _cities = [City objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}

+ (City *)cityWithName:(NSString *)name {
    if (name.length == 0) return nil;
    return [[[self cities] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name == %@", name]] firstObject];
}
@end
