


/***************** 正则表达式区 *****************/

#define AxcIsIntegerNumberRegular           @"^-?\\d+$"
#define AxcIsNumberTextRegular              @"^[0-9]*$"
#define AxcIsPhoneNumberRegular             @"^[1][3-9][0-9]{9}$"
#define AxcIsIdCardNumberRegular            @"^(\\d{14}|\\d{17})(\\d|[xX])$"
#define AxcIsEmailRegular                   @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define AxcIsURLRegular                     @"(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]"
#define AxcIsCarNumberRegular               @"^[\u4e00-\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fff]$"
#define AxcIsMacAddressRegular              @"([A-Fa-f0-9]{2}-){5}[A-Fa-f0-9]{2}"
#define AxcIsValidChineseRegular            @"^[\u4e00-\u9fa5]+$"
#define AxcIsValidPostalcodeRegular         @"^[0-8]\\d{5}(?!\\d)$"
#define AxcIsIPAddressRegular               @"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"
#define AxcIsIntegerNumberRegular           @"^-?\\d+$"
#define AxcIsPasswordRegular                @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}"
#define AxcIsUserNameRegular                @"^([\u4e00-\u9fa5]+|([a-zA-Z]+\\s?)+)$"
#define AxcIsBankNumberRegular              @"^([0-9]{16}|[0-9]{19})$"
#define AxcIsNumberAndStringRegular         @"^[A-Za-z0-9]+$"



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

#define AxcAuthenticationText           @"请进行身份验证"
#define AxcInputPasswordText            @"输入密码"

#define AxcYearsFomat                   @"yyyy"
#define AxcMonthFomat                   @"MM"
#define AxcDayFomat                     @"dd"
#define AxcHoursFomat                   @"HH"
#define AxcMinutesFomat                 @"mm"
#define AxcSecondsFomat                 @"ss"

/***************** 函数块区 *****************/

/** 获取当前语言 */
#define AxcGetLSC [[NSLocale preferredLanguages] objectAtIndex:0]

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
#define kAxcLanguageManagementStatistics    @"kAxcLanguageManagementStatistics"
#define kAxcBasicSuitMark_ID                @"kAxcLogo"
#define kAxcBasicSuitBarRightItemTag        @"Right"
#define kAxcBasicSuitBarLeftItemTag         @"Left"
#define kAxcBasicSuitSegmentation           @"-"

/***************** 通用宏定义 *****************/


/**
 AxcTool错误日志打印函数
 @param FORMAT 错误内容
 */
#define AxcErrorLog(FORMAT, ...) printf("%s",[[NSString stringWithFormat:@"\n############## AXC-TOOLS-ERROR ##############\nAxcToolsError: \n[ %@ |行号：%d ] | [执行函数：%s]:\n%@\n\n##############-AXC-TOOLS-ERROR-END ##############\n\n",self,__LINE__,__func__,##__VA_ARGS__] UTF8String]);
/**
 AxcTool错误日志打印函数
 @param errorObj 错误对象
 */
#define AxcErrorObjLog(obj) AxcErrorLog(@"%@",obj);


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



/** 是否是IPX 兼容模拟器和真机的纵横屏模式 */
#define kAxc_is_IPX \
^(){\
BOOL ScreenWidth_bol = kScreenWidth == 375|| kScreenWidth == 812;\
BOOL ScreenHeight_bol = kScreenWidth == 375 || kScreenWidth == 812;\
BOOL ScreenFor_IPX = ScreenWidth_bol && ScreenHeight_bol;\
BOOL models = [AxcParameterObj new].axcSystemVersionType == AxcSystemVersionType_iPhone_X ||\
[AxcParameterObj new].axcSystemVersionType == AxcSystemVersionType_iPhone_Simulator;\
return ScreenFor_IPX && models;\
}()



/** 宏取TabBar高度，支持纵横屏 */
#define AxcGetTabBarHeight      kAxc_is_IPX ? 83:49
/** 宏取NavBar高度，支持纵横屏 */
#define AxcGetNavBarHeight      kAxc_is_IPX ? 88:44
/** 宏取StatusBar高度，支持纵横屏 */
#define AxcGetStatusBarHeight   kAxc_is_IPX ? 44:20



/** Weak弱引用 */
#define WeakSelf __weak typeof(self)weakSelf = self;
/** Weak弱引用 */
#define WeakObj(obj) autoreleasepool{} __weak typeof(obj) obj##weakObj = obj;
/** Strong强引用 */
#define StrongSelf __strong typeof(weakSelf)self = weakSelf;
/** Strong强引用 */
#define StrongObj(obj) autoreleasepool{} __strong typeof(obj) obj##strongObj = obj;



/** GCD - 一次性执行 */
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
/** GCD - 在Main线程上运行 */
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
/** GCD - 开启异步线程 */
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlock);


