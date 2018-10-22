
/**  这个头文件可以放在PCH里，这里是允许全局引用的工具类  */

#pragma mark - Foundation 数据操作类扩展

#import "NSObject+AxcBasicSuitIndexPath.h"              // NSObject标记扩展
#import "NSObject+AxcBasicSuitObjectEx.h"               // 通用对象扩展，快速获取UserDefult、Appdelegate、通知中心等

#import "NSString+AxcRegularEx.h"                       // NSString快速决策正则
#import "NSString+AxcTextCalculation.h"                 // NSString快速计算宽高
#import "NSString+AxcStringIsReasonable.h"              // NSString是否合理，存在、不为空
#import "NSString+AxcReplaceRichText.h"                 // 将字符串标记颜色，并且变成富文本
#import "NSString+AxcEnumerate.h"                       // 遍历字符串
#import "NSString+AxcUrlEncode.h"                       // 编码解码

#import "NSMutableArray+AxcOperationEx.h"               // 可变数组操作

#import "NSDate+AxcProcessingEx.h"                      // 日期处理扩展
#import "NSDate+AxcDateArithmeticEx.h"                  // 日期加减法

#pragma mark - UIKit 视图操作类扩展

#import "UIView+AxcViewRectEx.h"                        // 快速赋值视图Rect属性
#import "UIView+AxcViewAppearanceEx.h"                  // 快速设置视图外观属性
#import "UIView+AxcGetSuperVC.h"                        // 获取当前VC、父VC、显示VC等
#import "UIView+AxcScreenshotsViewEx.h"                 // 对View截图

#import "UIButton+AxcButtonCountDown.h"                 // 快速设置按钮倒计时
#import "UIButton+AxcButtonContentLayout.h"             // 快速设置按钮布局模式

#import "UITextField+AxcPlaceholderLabelEx.h"           // 获取Text文本框的展位符Label

#import "UILabel+AxcCopyable.h"                         // 一个类别,可开启长按UILabel复制功能

#import "UIColor+AxcColorEx.h"                          // 颜色工具类

#import "UIImage+AxcQRCode.h"                           // 快速生成二维码
#import "UIImage+AxcTransfromZoom.h"                    // 缩放图片
#import "UIImage+AxcSpecialEffectsDrawing.h"            // 特效渲染
#import "UIImage+AxcImageRotating.h"                    // 绘制旋转图片

#import "UIViewController+AxcVCBackButtonEvent.h"       // VC返回回调
#import "UIViewController+AxcVCPushName.h"              // VC根据类名推出VC

#import "UIGestureRecognizer+AxcActionBlockEx.h"        // 手势使用Block方式触发

#pragma mark - 宏定义

#import "AxcBasicSuitDefine.h"                          // 快速宏定义

#pragma mark - 对象处理类

#import "AxcLanguageManagement.h"                       // 语言操作对象
#import "AxcCalculateTool.h"                            // 计算/转换工具
#import "AxcParameterObj.h"                             // 机型判断
#import "AxcDataCache.h"                                // 二进制缓存器
#import "AxcTouchManager.h"                             // 指纹验证管理器




