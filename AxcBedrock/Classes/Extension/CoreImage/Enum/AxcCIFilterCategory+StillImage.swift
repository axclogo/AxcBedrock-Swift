//
//  AxcCIFilterCategory+Type.swift
//  Pods
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

// MARK: - [AxcCIFilterCategory.StillImage]

public extension AxcCIFilterCategory {
    /// 静态图像
    enum StillImage: String {
        /// 手风琴折叠过渡
        case accordionFoldTransition
        /// 加法合成
        case additionCompositing
        /// 仿射夹紧
        case affineClamp
        /// 仿射平铺
        case affineTile
        /// 仿射变换
        case affineTransform
        /// 区域平均值
        case areaAverage
        /// 区域直方图
        case areaHistogram
        /// 区域对数直方图
        case areaLogarithmicHistogram
        /// 区域最大值
        case areaMaximum
        /// 区域最大Alpha值
        case areaMaximumAlpha
        /// 区域最小值
        case areaMinimum
        /// 区域最小Alpha值
        case areaMinimumAlpha
        /// 区域最小最大值
        case areaMinMax
        /// 区域最小最大红色值
        case areaMinMaxRed
        /// 属性文本图像生成器
        case attributedTextImageGenerator
        /// Aztec码生成器
        case aztecCodeGenerator
        /// 条形码生成器
        case barcodeGenerator
        /// 条纹滑动过渡
        case barsSwipeTransition
        /// 双三次缩放变换
        case bicubicScaleTransform
        /// 放置Alpha蒙版
        case blendWithAlphaMask
        /// 放置蓝色蒙版
        case blendWithBlueMask
        /// 放置蒙版
        case blendWithMask
        /// 放置红色蒙版
        case blendWithRedMask
        /// 开花效果
        case bloom
        /// 光晕模糊
        case bokehBlur
        /// 方框模糊
        case boxBlur
        /// 凸凹畸变
        case bumpDistortion
        /// 线性凸凹畸变
        case bumpDistortionLinear
        /// 相机校准镜头校正
        case cameraCalibrationLensCorrection
        /// 棋盘生成器
        case checkerboardGenerator
        /// 圆涟漪畸变
        case circleSplashDistortion
        /// 圆形屏幕
        case circularScreen
        /// 圆形包
        case circularWrap
        /// 夹紧
        case clamp
        /// CMYK半色调
        case cMYKHalftone
        /// Code 128条形码生成器
        case code128BarcodeGenerator
        /// 颜色绝对差异
        case colorAbsoluteDifference
        /// 颜色混合模式
        case colorBlendMode
        /// 颜色燃烧混合模式
        case colorBurnBlendMode
        /// 颜色夹紧
        case colorClamp
        /// 颜色控制
        case colorControls
        /// 颜色交叉多项式
        case colorCrossPolynomial
        /// 颜色立方体
        case colorCube
        /// 颜色混合立方体和蒙版
        case colorCubesMixedWithMask
        /// 颜色空间的颜色立方体
        case colorCubeWithColorSpace
        /// 颜色曲线
        case colorCurves
        /// 颜色避光混合模式
        case colorDodgeBlendMode
        /// 颜色反转
        case colorInvert
        /// 颜色映射
        case colorMap
        /// 颜色矩阵
        case colorMatrix
        /// 颜色单色
        case colorMonochrome
        /// 颜色多项式
        case colorPolynomial
        /// 颜色分色
        case colorPosterize
        /// 颜色阈值
        case colorThreshold
        /// Otsu 颜色阈值
        case colorThresholdOtsu
        /// 列平均值
        case columnAverage
        /// 漫画效果
        case comicEffect
        /// 常量颜色生成器
        case constantColorGenerator
        /// 转换 Lab 到 RGB
        case convertLabToRGB
        /// 转换 RGB 到 Lab
        case convertRGBtoLab
        /// 3x3 卷积
        case convolution3X3
        /// 5x5 卷积
        case convolution5X5
        /// 7x7 卷积
        case convolution7X7
        /// 9x1 水平卷积
        case convolution9Horizontal
        /// 垂直9x1 卷积
        case convolution9Vertical
        /// RGB 3x3 卷积
        case convolutionRGB3X3
        /// RGB 5x5 卷积
        case convolutionRGB5X5
        /// RGB 7x7 卷积
        case convolutionRGB7X7
        /// RGB 水平9x1 卷积
        case convolutionRGB9Horizontal
        /// RGB 垂直9x1 卷积
        case convolutionRGB9Vertical
        /// 复印机转场
        case copyMachineTransition
        /// Core ML 模型过滤器
        case coreMLModelFilter
        /// 裁剪
        case crop
        /// 结晶化
        case crystallize
        /// 暗化混合模式
        case darkenBlendMode
        /// 深度模糊效果
        case depthBlurEffect
        /// 景深效果
        case depthOfField
        /// 深度转视差
        case depthToDisparity
        /// 差异混合模式
        case differenceBlendMode
        /// 圆盘模糊
        case discBlur
        /// 使用遮罩的解体转场
        case disintegrateWithMaskTransition
        /// 视差转深度
        case disparityToDepth
        /// 位移畸变
        case displacementDistortion
        /// 溶解转场
        case dissolveTransition
        /// 抖动
        case dither
        /// 除法混合模式
        case divideBlendMode
        /// 文档增强器
        case documentEnhancer
        /// 点阵屏幕
        case dotScreen
        /// Droste 效果
        case droste
        /// 边缘保留上采样滤镜
        case edgePreserveUpsampleFilter
        /// 边缘
        case edges
        /// 边缘处理
        case edgeWork
        /// 八方向反射平铺
        case eightfoldReflectedTile
        /// 排除混合模式
        case exclusionBlendMode
        /// 曝光调整
        case exposureAdjust
        /// 伪彩色
        case falseColor
        /// 闪光转场
        case flashTransition
        /// 四方向反射平铺
        case fourfoldReflectedTile
        /// 四方向旋转平铺
        case fourfoldRotatedTile
        /// 四方向平移平铺
        case fourfoldTranslatedTile
        /// Gabor 梯度
        case gaborGradients
        /// Gamma 调整
        case gammaAdjust
        /// 高斯模糊
        case gaussianBlur
        /// 高斯梯度
        case gaussianGradient
        /// 玻璃畸变
        case glassDistortion
        /// 玻璃菱形
        case glassLozenge
        /// 滑动反射平铺
        case glideReflectedTile
        /// 阴暗
        case gloom
        /// 引导滤波
        case guidedFilter
        /// 强光混合模式
        case hardLightBlendMode
        /// 孵化屏幕
        case hatchedScreen
        /// 从遮罩生成高度场
        case heightFieldFromMask
        /// 六边形像素化
        case hexagonalPixellate
        /// 高光阴影调整
        case highlightShadowAdjust
        /// 直方图显示滤镜
        case histogramDisplayFilter
        /// 孔洞畸变
        case holeDistortion
        /// 色相调整
        case hueAdjust
        /// 色相混合模式
        case hueBlendMode
        /// 色相饱和度亮度梯度
        case hueSaturationValueGradient
        /// 万花筒
        case kaleidoscope
        /// 倾斜校正（组合）
        case keystoneCorrectionCombined
        /// 倾斜校正（水平）
        case keystoneCorrectionHorizontal
        /// 倾斜校正（垂直）
        case keystoneCorrectionVertical
        /// k-means
        case kMeans
        /// Lab 色彩差异
        case labDeltaE
        /// Lanczos 缩放变换
        case lanczosScaleTransform
        /// 透镜光晕生成器
        case lenticularHaloGenerator
        /// 加亮混合模式
        case lightenBlendMode
        /// 光隧道
        case lightTunnel
        /// 线性加深混合模式
        case linearBurnBlendMode
        /// 线性减淡混合模式
        case linearDodgeBlendMode
        /// 线性渐变
        case linearGradient
        /// 线性光混合模式
        case linearLightBlendMode
        /// 线性到 sRGB 色调曲线
        case linearToSRGBToneCurve
        /// 线条叠加
        case lineOverlay
        /// 线条屏幕
        case lineScreen
        /// 亮度混合模式
        case luminosityBlendMode
        /// 蒙版可变模糊
        case maskedVariableBlur
        /// 蒙版转为透明度
        case maskToAlpha
        /// 最大分量
        case maximumComponent
        /// 最大合成
        case maximumCompositing
        /// 中值滤波
        case medianFilter
        /// 网格生成器
        case meshGenerator
        /// 最小分量
        case minimumComponent
        /// 最小合成
        case minimumCompositing
        /// 混合
        case mix
        /// 模块转场
        case modTransition
        /// 形态学梯度
        case morphologyGradient
        /// 形态学最大值
        case morphologyMaximum
        /// 形态学最小值
        case morphologyMinimum
        /// 矩形形态学最大值
        case morphologyRectangleMaximum
        /// 矩形形态学最小值
        case morphologyRectangleMinimum
        /// 运动模糊
        case motionBlur
        /// 乘法混合模式
        case multiplyBlendMode
        /// 乘法合成
        case multiplyCompositing
        /// 九块拉伸
        case ninePartStretched
        /// 九块平铺
        case ninePartTiled
        /// 降噪
        case noiseReduction
        /// OP 图块
        case opTile
        /// 叠加混合模式
        case overlayBlendMode
        /// 翻页过渡
        case pageCurlTransition
        /// 带阴影的翻页过渡
        case pageCurlWithShadowTransition
        /// 调色板中心
        case paletteCentroid
        /// 调色板
        case palettize
        /// 平行四边形图块
        case parallelogramTile
        /// PDF417 条形码生成器
        case pDF417BarcodeGenerator
        /// 人物分割
        case personSegmentation
        /// 透视校正
        case perspectiveCorrection
        /// 透视旋转
        case perspectiveRotate
        /// 透视图块
        case perspectiveTile
        /// 透视变换
        case perspectiveTransform
        /// 带范围的透视变换
        case perspectiveTransformWithExtent
        /// 光晕效果
        case photoEffectChrome
        /// 褪色效果
        case photoEffectFade
        /// 即时效果
        case photoEffectInstant
        /// 黑白效果
        case photoEffectMono
        /// 黑色效果
        case photoEffectNoir
        /// 处理效果
        case photoEffectProcess
        /// 色调效果
        case photoEffectTonal
        /// 印象效果
        case photoEffectTransfer
        /// 捏合畸变
        case pinchDistortion
        /// 销光混合模式
        case pinLightBlendMode
        /// 像素化
        case pixellate
        /// 点缀化
        case pointillize
        /// 二维码生成器
        case qrCodeGenerator
        /// 径向渐变
        case radialGradient
        /// 随机生成器
        case randomGenerator
        /// 波纹过渡
        case rippleTransition
        /// 圆角矩形生成器
        case roundedRectangleGenerator
        /// 行平均
        case rowAverage
        /// 显著性图滤镜
        case saliencyMapFilter
        /// 最近采样
        case sampleNearest
        /// 饱和度混合模式
        case saturationBlendMode
        /// 屏幕混合模式
        case screenBlendMode
        /// 棕褐色调
        case sepiaTone
        /// 阴影材质
        case shadedMaterial
        /// 锐化亮度
        case sharpenLuminance
        /// 六重倒影瓦片
        case sixfoldReflectedTile
        /// 六重旋转瓦片
        case sixfoldRotatedTile
        /// 平滑线性渐变
        case smoothLinearGradient
        /// 柔光混合模式
        case softLightBlendMode
        /// 源在顶部合成
        case sourceAtopCompositing
        /// 源在内部合成
        case sourceInCompositing
        /// 源在外部合成
        case sourceOutCompositing
        /// 源在上方合成
        case sourceOverCompositing
        /// 点色
        case spotColor
        /// 聚光灯
        case spotLight
        /// sRGB曲线转线性
        case sRGBToneCurveToLinear
        /// 星光发射器
        case starShineGenerator
        /// 校正滤镜
        case straightenFilter
        /// 伸展裁剪
        case stretchCrop
        /// 条纹生成器
        case stripesGenerator
        /// 减法混合模式
        case subtractBlendMode
        /// 阳光生成器
        case sunbeamsGenerator
        /// 滑动过渡
        case swipeTransition
        /// 色温和色调
        case temperatureAndTint
        /// 文字图片生成器
        case textImageGenerator
        /// 热能
        case thermal
        /// 色调曲线
        case toneCurve
        /// 圆环透镜畸变
        case torusLensDistortion
        /// 三角镜像对称
        case triangleKaleidoscope
        /// 三角瓷砖
        case triangleTile
        /// 十二重倒影瓷砖
        case twelvefoldReflectedTile
        /// 扭曲畸变
        case twirlDistortion
        /// 锐化层蒙版
        case unsharpMask
        /// 饱和度
        case vibrance
        /// 暗角
        case vignette
        /// 暗角效果
        case vignetteEffect
        /// 鲜艳光混合模式
        case vividLightBlendMode
        /// 漩涡畸变
        case vortexDistortion
        /// 白点调整
        case whitePointAdjust
        /// X光
        case xRay
        /// 缩放模糊
        case zoomBlur
    }
}

// MARK: - AxcCIFilterCategory.StillImage + _AxcCIFilterNameProtocol

extension AxcCIFilterCategory.StillImage: _AxcCIFilterNameProtocol { }
