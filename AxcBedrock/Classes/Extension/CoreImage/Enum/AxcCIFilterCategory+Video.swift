//
//  AxcCIFilterCategory+Type.swift
//  Pods
//
//  Created by 赵新 on 2023/7/31.
//

import CoreImage

// MARK: - [AxcCIFilterCategory.Video]

public extension AxcCIFilterCategory {
    /// 视频
    enum Video: String {
        /// 手风琴折叠过渡效果
        case accordionFoldTransition
        /// 加法合成
        case additionCompositing
        /// 仿射夹紧
        case affineClamp
        /// 仿射平铺
        case affineTile
        /// 仿射变换
        case affineTransform
        /// 区域平均
        case areaAverage
        /// 区域直方图
        case areaHistogram
        /// 区域对数直方图
        case areaLogarithmicHistogram
        /// 区域最大值
        case areaMaximum
        /// 区域最大值Alpha通道
        case areaMaximumAlpha
        /// 区域最小值
        case areaMinimum
        /// 区域最小值Alpha通道
        case areaMinimumAlpha
        /// 区域最小最大值
        case areaMinMax
        /// 区域最小最大值（红色通道）
        case areaMinMaxRed
        /// 富文本图像生成器
        case attributedTextImageGenerator
        /// 条码生成器
        case barcodeGenerator
        /// 条纹滑动过渡效果
        case barsSwipeTransition
        /// 双三次缩放变换
        case bicubicScaleTransform
        /// 使用Alpha掩码混合
        case blendWithAlphaMask
        /// 使用蓝色掩码混合
        case blendWithBlueMask
        /// 使用掩码混合
        case blendWithMask
        /// 使用红色掩码混合
        case blendWithRedMask
        /// 泛光效果
        case bloom
        /// 角模模糊
        case bokehBlur
        /// 盒状模糊
        case boxBlur
        /// 凸起畸变
        case bumpDistortion
        /// 线性凸起畸变
        case bumpDistortionLinear
        /// 相机校准透镜矫正
        case cameraCalibrationLensCorrection
        /// 棋盘生成器
        case checkerboardGenerator
        /// 圆形溅射畸变
        case circleSplashDistortion
        /// 圆形屏幕
        case circularScreen
        /// 圆形包裹
        case circularWrap
        /// 限制
        case clamp
        /// CMYK半色调
        case cMYKHalftone
        /// 颜色绝对差异
        case colorAbsoluteDifference
        /// 颜色混合模式
        case colorBlendMode
        /// 颜色烧蚀混合模式
        case colorBurnBlendMode
        /// 颜色夹紧
        case colorClamp
        /// 颜色控制
        case colorControls
        /// 颜色交叉多项式
        case colorCrossPolynomial
        /// 颜色立方体
        case colorCube
        /// 与掩码混合的颜色立方体
        case colorCubesMixedWithMask
        /// 使用颜色空间的颜色立方体
        case colorCubeWithColorSpace
        /// 颜色曲线
        case colorCurves
        /// 颜色避免混合模式
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
        /// 颜色色阶
        case colorPosterize
        /// 颜色阈值
        case colorThreshold
        /// 颜色OTSU阈值
        case colorThresholdOtsu
        /// 列平均值
        case columnAverage
        /// 连环漫画效果
        case comicEffect
        /// 常量颜色生成器
        case constantColorGenerator
        /// 将Lab转换为RGB
        case convertLabToRGB
        /// 将RGB转换为Lab
        case convertRGBtoLab
        /// 3x3卷积
        case convolution3X3
        /// 5x5卷积
        case convolution5X5
        /// 7x7卷积
        case convolution7X7
        /// 9个水平方向卷积
        case convolution9Horizontal
        /// 9个垂直方向卷积
        case convolution9Vertical
        /// 3x3RGB卷积
        case convolutionRGB3X3
        /// 5x5RGB卷积
        case convolutionRGB5X5
        /// 7x7RGB卷积
        case convolutionRGB7X7
        /// 9个水平方向RGB卷积
        case convolutionRGB9Horizontal
        /// 9个垂直方向RGB卷积
        case convolutionRGB9Vertical
        /// 复制机过渡效果
        case copyMachineTransition
        /// 剪裁
        case crop
        /// 结晶化
        case crystallize
        /// 加深混合模式
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
        /// 使用掩码分解过渡效果
        case disintegrateWithMaskTransition
        /// 视差转深度
        case disparityToDepth
        /// 位移畸变
        case displacementDistortion
        /// 溶解过渡效果
        case dissolveTransition
        /// 抖动
        case dither
        /// 除法混合模式
        case divideBlendMode
        /// 点阵屏幕
        case dotScreen
        /// 杜罗斯特
        case droste
        /// 边缘保持上采样滤波器
        case edgePreserveUpsampleFilter
        /// 边缘
        case edges
        /// 边缘增强
        case edgeWork
        /// 八折反射瓷砖
        case eightfoldReflectedTile
        /// 排除混合模式
        case exclusionBlendMode
        /// 曝光调整
        case exposureAdjust
        /// 伪彩色
        case falseColor
        /// 闪光过渡效果
        case flashTransition
        /// 四折反射瓷砖
        case fourfoldReflectedTile
        /// 四折旋转瓷砖
        case fourfoldRotatedTile
        /// 四折平移瓷砖
        case fourfoldTranslatedTile
        /// Gabor梯度
        case gaborGradients
        /// 伽马调整
        case gammaAdjust
        /// 高斯模糊
        case gaussianBlur
        /// 高斯梯度
        case gaussianGradient
        /// 玻璃畸变
        case glassDistortion
        /// 玻璃菱形
        case glassLozenge
        /// 滑行反射瓷砖
        case glideReflectedTile
        /// 昏黄
        case gloom
        /// 引导滤波器
        case guidedFilter
        /// 强光混合模式
        case hardLightBlendMode
        /// 划痕屏幕
        case hatchedScreen
        /// 从遮罩生成高度场
        case heightFieldFromMask
        /// 六角像素化
        case hexagonalPixellate
        /// 高光阴影调整
        case highlightShadowAdjust
        /// 直方图显示滤波器
        case histogramDisplayFilter
        /// 孔洞畸变
        case holeDistortion
        /// 色调调整
        case hueAdjust
        /// 色调混合模式
        case hueBlendMode
        /// 色调饱和度价值渐变
        case hueSaturationValueGradient
        /// 万花筒
        case kaleidoscope
        /// 键石校正（综合）
        case keystoneCorrectionCombined
        /// 键石校正（水平）
        case keystoneCorrectionHorizontal
        /// 键石校正（垂直）
        case keystoneCorrectionVertical
        /// k均值
        case kMeans
        /// LAB Delta E
        case labDeltaE
        /// Lanczos缩放变换
        case lanczosScaleTransform
        /// 聚焦光晕生成器
        case lenticularHaloGenerator
        /// 减淡混合模式
        case lightenBlendMode
        /// 光隧道
        case lightTunnel
        /// 线性燃烧混合模式
        case linearBurnBlendMode
        /// 线性减淡混合模式
        case linearDodgeBlendMode
        /// 线性渐变
        case linearGradient
        /// 线性光混合模式
        case linearLightBlendMode
        /// 线性到SRGB色调曲线
        case linearToSRGBToneCurve
        /// 线条叠加
        case lineOverlay
        /// 线条屏幕
        case lineScreen
        /// 亮度混合模式
        case luminosityBlendMode
        /// 掩码可变模糊
        case maskedVariableBlur
        /// 掩码转换为透明度
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
        /// 模渐变
        case modTransition
        /// 形态学梯度
        case morphologyGradient
        /// 形态学最大值
        case morphologyMaximum
        /// 形态学最小值
        case morphologyMinimum
        /// 矩形最大值
        case morphologyRectangleMaximum
        /// 矩形最小值
        case morphologyRectangleMinimum
        /// 运动模糊
        case motionBlur
        /// 乘法混合模式
        case multiplyBlendMode
        /// 乘法合成
        case multiplyCompositing
        /// 九宫格拉伸
        case ninePartStretched
        /// 九宫格平铺
        case ninePartTiled
        /// 降噪
        case noiseReduction
        /// OP图块
        case opTile
        /// 叠加混合模式
        case overlayBlendMode
        /// 翻页过渡
        case pageCurlTransition
        /// 带阴影的翻页过渡
        case pageCurlWithShadowTransition
        /// 调色板的中心
        case paletteCentroid
        /// 生成调色板
        case palettize
        /// 平行四边形平铺
        case parallelogramTile
        /// PDF417条形码生成器
        case pDF417BarcodeGenerator
        /// 人体分割
        case personSegmentation
        /// 透视校正
        case perspectiveCorrection
        /// 透视旋转
        case perspectiveRotate
        /// 透视平铺
        case perspectiveTile
        /// 透视变换
        case perspectiveTransform
        /// 带范围的透视变换
        case perspectiveTransformWithExtent
        /// 单色冷凝
        case photoEffectChrome
        /// 增加淡出效果
        case photoEffectFade
        /// 瞬间特效
        case photoEffectInstant
        /// 黑白特效
        case photoEffectMono
        /// 黑色特效
        case photoEffectNoir
        /// 处理特效
        case photoEffectProcess
        /// 色调特效
        case photoEffectTonal
        /// 转移特效
        case photoEffectTransfer
        /// 捏合畸变
        case pinchDistortion
        /// 针光混合模式
        case pinLightBlendMode
        /// 像素化
        case pixellate
        /// 点阵化
        case pointillize
        /// 径向渐变
        case radialGradient
        /// 随机生成器
        case randomGenerator
        /// 波纹过渡
        case rippleTransition
        /// 行平均
        case rowAverage
        /// 显著性图滤波器
        case saliencyMapFilter
        /// 最近采样
        case sampleNearest
        /// 饱和度混合模式
        case saturationBlendMode
        /// 屏幕混合模式
        case screenBlendMode
        /// 褐色调
        case sepiaTone
        /// 阴影材质
        case shadedMaterial
        /// 锐化亮度
        case sharpenLuminance
        /// 六重反射平铺
        case sixfoldReflectedTile
        /// 六重旋转平铺
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
        /// 点颜色
        case spotColor
        /// 聚光灯
        case spotLight
        /// sRGB曲线转线性
        case sRGBToneCurveToLinear
        /// 星光生成器
        case starShineGenerator
        /// 校正滤波器
        case straightenFilter
        /// 拉伸裁剪
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
        /// 文本图像生成器
        case textImageGenerator
        /// 热图
        case thermal
        /// 色调曲线
        case toneCurve
        /// 圆环镜头畸变
        case torusLensDistortion
        /// 三角形万花筒
        case triangleKaleidoscope
        /// 三角形平铺
        case triangleTile
        /// 十二重反射平铺
        case twelvefoldReflectedTile
        /// 旋涡畸变
        case twirlDistortion
        /// 锐化遮罩
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
        /// X射线
        case xRay
        /// 缩放模糊
        case zoomBlur
    }
}

// MARK: - AxcCIFilterCategory.Video + _AxcCIFilterNameProtocol

extension AxcCIFilterCategory.Video: _AxcCIFilterNameProtocol { }
