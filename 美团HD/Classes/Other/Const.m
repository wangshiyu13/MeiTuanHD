#import <UIKit/UIKit.h>

CGFloat const ScreenMaxWH = 1024;
CGFloat const ScreenMinWH = 768;

/** 订单限制数 */
int const kDealLimit = 12;

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

/** 城市改变通知 */
NSString *const CityDidChangeNotification = @"CityDidChangeNotification";
/** 通过这个key可以取出当前的城市模型 */
NSString *const CurrentCityKey = @"CurrentCityKey";

/** 区域改变通知 */
NSString *const DistrictDidChangeNotification = @"DistrictDidChangeNotification";
/** 通过这个key可以取出当前的区域模型 */
NSString *const CurrentDistrictKey = @"CurrentDistrictKey";
/** 通过这个key可以取出当前的子区域的索引 */
NSString *const CurrentSubdistrictIndexKey = @"CurrentSubdistrictIndexKey";

/** DealCell的cover点击通知 */
NSString *const CellCoverDidClickNotification = @"CellCoverDidClickNotification";