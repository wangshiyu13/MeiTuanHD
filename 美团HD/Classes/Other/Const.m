#import <UIKit/UIKit.h>

/** 排序改变通知 */
NSString *const SortDidChangeNotification = @"SortDidChangeNotification";
/** 通过这个key可以取出当前的排序模型 */
NSString *const CurrentSortKey = @"CurrentSortKey";

/** 类别改变通知 */
NSString *const CategoryDidChangeNotification = @"CategoryDidChangeNotification";
/** 通过这个key可以取出当前的类别模型 */
NSString *const CurrentCategoryKey = @"CurrentCategoryKey";
/** 通过这个key可以取出当前的子类别的索引 */
NSString *const CurrentSubcategoryIndexKey = @"CurrentSubcategoryIndexKey";