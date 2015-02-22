#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const ScreenMaxWH;
UIKIT_EXTERN CGFloat const ScreenMinWH;
/** 订单限制数 */
UIKIT_EXTERN int const kDealLimit;
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

/** 城市改变通知 */
UIKIT_EXTERN NSString *const CityDidChangeNotification;
/** 通过这个key可以取出当前的城市模型 */
UIKIT_EXTERN NSString *const CurrentCityKey;

/** 区域改变通知 */
UIKIT_EXTERN NSString *const DistrictDidChangeNotification;
/** 通过这个key可以取出当前的区域模型 */
UIKIT_EXTERN NSString *const CurrentDistrictKey;
/** 通过这个key可以取出当前的子区域的索引 */
UIKIT_EXTERN NSString *const CurrentSubdistrictIndexKey;

/** DealCell的cover点击通知 */
UIKIT_EXTERN NSString *const CellCoverDidClickNotification;