#
# Be sure to run `pod lib lint AxcBedrock.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'AxcBedrock'
    
    s.version          = '5.0.5'
    
    s.swift_version    = '5.0'
    
    s.summary          = '基岩工具库'
    
    s.description      =
    <<-DESC
    基岩工具库，将坑洼不平的各种苹果开发平台的Api调用统一，帮助iOS开发并快速过渡到任意平台开发，并能迅速操作基础Api
    目前支持iOS与MacOS双平台运作，Api相似度99%，可以平滑从iOS过渡到MacOS
    DESC
    
    s.homepage         = 'https://github.com/axclogo/AxcBedrock'
    
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    
    s.author           = { 'Axclogo' => 'axclogo@163.com' }
    
    s.source           = { :git => 'http://gitlab.zhaogong.vrtbbs.com/yupaoios/components/AxcBedrock.git', :tag => s.version.to_s }
    
    s.pod_target_xcconfig = {
        'CODE_SIGNING_ALLOWED' => 'NO'
    }
    
    s.requires_arc = true
    
    # 设置子库 ===>
    # 文件类型
    fileType = "{swift,h,m,mm,cpp}"
    # 基础路径
    baseFilePath = "AxcBedrock/Classes"
    
    # 核心文件（不可或缺）
    Core_files = [
    "#{baseFilePath}/Core/**/*.#{fileType}",
    "#{baseFilePath}/Utils/**/*.#{fileType}",
    "#{baseFilePath}/Enum/**/*.#{fileType}",
    "#{baseFilePath}/Extension/SwiftLib/**/*.#{fileType}",
    "#{baseFilePath}/Extension/Foundation/**/*.#{fileType}"
    ]
    # 属性包装器文件
    Wrapper_files = "#{baseFilePath}/Wrapper/**/*.#{fileType}"
    # 跨平台文件
    CrossPlatform_files = "#{baseFilePath}/Extension/CrossPlatform/**/*.#{fileType}"
    # 其他库文件路径
    # 因为拆分更细化的子库属实没必要，如果使用子库的话上传至Repo还需要进一步校验
    # 于是改为文件路径导入方式
    #    _files = "#{baseFilePath}/Extension/xxxx/**/*.#{fileType}"
    AVFoundation_files = "#{baseFilePath}/Extension/AVFoundation/**/*.#{fileType}"
    CoreFoundation_files = "#{baseFilePath}/Extension/CoreFoundation/**/*.#{fileType}"
    CoreGraphics_files = "#{baseFilePath}/Extension/CoreGraphics/**/*.#{fileType}"
    CoreImage_files = "#{baseFilePath}/Extension/CoreImage/**/*.#{fileType}"
    CoreLocation_files = "#{baseFilePath}/Extension/CoreLocation/**/*.#{fileType}"
    CoreMedia_files = "#{baseFilePath}/Extension/CoreMedia/**/*.#{fileType}"
    CoreText_files = "#{baseFilePath}/Extension/CoreText/**/*.#{fileType}"
    CoreVideo_files = "#{baseFilePath}/Extension/CoreVideo/**/*.#{fileType}"
    LocalAuthentication_files = "#{baseFilePath}/Extension/LocalAuthentication/**/*.#{fileType}"
    MapKit_files = "#{baseFilePath}/Extension/MapKit/**/*.#{fileType}"
    QuartzCore_files = "#{baseFilePath}/Extension/QuartzCore/**/*.#{fileType}"
    WebKit_files = "#{baseFilePath}/Extension/WebKit/**/*.#{fileType}"
    
    
    #iOS平台
    s.ios.deployment_target = '11.0'
    
    # iOS平台文件
    ios_source_files =
    Core_files +
    [
    "#{baseFilePath}/Extension/UIKit/**/*.#{fileType}", # 主要文件
    Wrapper_files, # 属性包装器
    CrossPlatform_files, # 跨平台
    AVFoundation_files,
    CoreFoundation_files,
    CoreGraphics_files,
    CoreImage_files,
    CoreLocation_files,
    CoreMedia_files,
    CoreText_files,
    CoreVideo_files,
    LocalAuthentication_files,
    MapKit_files,
    QuartzCore_files,
    WebKit_files
    ]
    s.ios.source_files = ios_source_files
    
    
    # macOS平台
    s.osx.deployment_target = '11.0'
    
    # macOS平台文件
    osx_source_files =
    Core_files +
    [
    "#{baseFilePath}/Extension/AppKit/**/*.#{fileType}", # 主要文件
    Wrapper_files, # 属性包装器
    CrossPlatform_files, # 跨平台
    CoreFoundation_files,
    CoreGraphics_files,
    CoreImage_files,
    CoreLocation_files,
    CoreMedia_files,
    CoreText_files,
    CoreVideo_files,
    QuartzCore_files,
    WebKit_files
    ]
    s.osx.source_files = osx_source_files
    
    # Core主模块
    s.subspec 'Core' do |c|
        c.source_files = Core_files
    end
    
    # iOS平台
    s.subspec 'iOS' do |c|
        c.ios.source_files = ios_source_files
        c.dependency 'AxcBedrock/Core'
        c.pod_target_xcconfig = {
            'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
            # 通过宏定义检测加载平台
#            'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => 'AxcBedrock_UIKit_Is_Load',
#            'GCC_PREPROCESSOR_DEFINITIONS' => 'AxcBedrock_UIKit_Is_Load=1'
        }
    end
    
    # MacOS平台
    s.subspec 'macOS' do |c|
        c.osx.source_files = osx_source_files
        c.dependency 'AxcBedrock/Core'
        c.pod_target_xcconfig = {
            'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
            # 通过宏定义检测加载平台
#            'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => 'AxcBedrock_AppKit_Is_Load',
#            'GCC_PREPROCESSOR_DEFINITIONS' => 'AxcBedrock_AppKit_Is_Load=1'
        }
    end
end
