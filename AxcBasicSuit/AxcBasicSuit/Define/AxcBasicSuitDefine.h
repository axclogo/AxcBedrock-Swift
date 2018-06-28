


/***************** 正则表达式区 *****************/
#define AxcIsIntegerNumberRegular           @"^-?\\d+$"
#define AxcIsNumberTextRegular              @"^[0-9]*$"
#define AxcIsPhoneNumberRegular             @"^[1][3-9][0-9]{9}$"
#define AxcIsIdCardNumberRegular            @"^(\\d{14}|\\d{17})(\\d|[xX])$"
#define AxcIsEmailRegular                   @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define AxcIsURLRegular                     @"(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]"
#define AxcIsCarNumberRegular           @"^[\u4e00-\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fff]$"
#define AxcIsMacAddressRegular           @"([A-Fa-f\\d]{2}:){5}[A-Fa-f\\d]{2}"
#define AxcIsValidChineseRegular           @"^[\u4e00-\u9fa5]+$"
#define AxcIsValidPostalcodeRegular           @"^[0-8]\\d{5}(?!\\d)$"
#define AxcIsIPAddressRegular           @"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"
#define AxcIsIntegerNumberRegular           @"^-?\\d+$"

/***************** 固定文本区 *****************/
#define AxcBasicSuitDetermineText       @"确定"
#define AxcBasicSuitCancelText          @"取消"
#define AxcBasicSuitWarningText         @"警告"
#define AxcBasicSuitPromptText          @"提示"
#define AxcBasicSuitDeleteText          @"删除"

#define AxcBasicSuitJustNowText         @"刚刚"
#define AxcBasicSuitMinutesText         @"分钟"
#define AxcBasicSuitHoursText           @"小时"
#define AxcBasicSuitDayText             @"天"
#define AxcBasicSuitBeforeText          @"前"
#define AxcBasicSuitYearsText           @"年"
#define AxcBasicSuitMonthText           @"月"
#define AxcBasicSuitDateText            @"日"

#define AxcBasicSuitUnknownText         @"未知"


/***************** 函数块区 *****************/

/**
 快速圆角定义宏
 @param View 视图
 @param Radius 圆角半径
 */
#define AxcRadiusView(View,Radius) View.layer.masksToBounds = YES; View.layer.cornerRadius = Radius;

/**
 根据Key选择设置语言
 @param key 中文Key
 @return 自适应语种
 */
#define AxcLS(key) [AxcLanguageManagement getLanguageString:key]

/**
 根据Key选择设置语言
 @param key 中文Key
 @param record 是否记录出现次数
 @return 自适应语种
 */
#define AxcLSR(key,record) [AxcLanguageManagement getLanguageString:key record:record]


/***************** 通用Key值定义 *****************/

/** 从UserDefults获取语言Key的统计 */
#define kAxcLanguageManagementStatistics @"kAxcLanguageManagementStatistics"


/***************** 通用宏定义 *****************/

/** 获取屏幕宽高大小 */
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上

#define kScreenWidth ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define kScreenSize ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenSize [UIScreen mainScreen].bounds.size
#endif







