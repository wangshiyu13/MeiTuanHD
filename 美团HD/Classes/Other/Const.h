#import <UIKit/UIKit.h>

/** 排序改变通知 */
UIKIT_EXTERN NSString *const SortDidChangeNotification;
/** 通过这个key可以取出当前的排序模型 */
UIKIT_EXTERN NSString *const CurrentSortKey;

/** 类别改变通知 */
UIKIT_EXTERN NSString *const CategoryDidChangeNotification;
/** 通过这个key可以取出当前的类别模型 */
UIKIT_EXTERN NSString *const CurrentCategoryKey;
/** 通过这个key可以取出当前的子类别的索引 */
UIKIT_EXTERN NSString *const CurrentSubcategoryIndexKey;