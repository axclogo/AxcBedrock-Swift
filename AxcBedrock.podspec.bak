#
# Be sure to run `pod lib lint AxcBedrock.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name          = 'AxcBedrock'
    
    s.version       = '1.1.1' # Auto Version
    
    s.summary       = 'Axc的基岩工具库'
    
    s.description   =
    <<-DESC
    基岩工具库，将坑洼不平的各种苹果开发平台的Api调用统一，帮助iOS开发并快速过渡到任意平台开发，并能迅速操作基础Api
    目前支持iOS与MacOS双平台运作，Api相似度99%，可以平滑从iOS过渡到MacOS
    DESC
    
    s.homepage      = 'https://github.com/axclogo/AxcBedrock'
    
    s.license       = { :type => 'MIT', :file => 'LICENSE' }
    
    s.author        = { 'Axclogo' => 'axclogo@163.com' }
    
    s.source        = { :git => 'https://github.com/axclogo/AxcBedrock-Swift.git', :tag => s.version.to_s }
    
    s.swift_version = '5.0'
    
    s.requires_arc  = true
    
    s.pod_target_xcconfig = {
        'CODE_SIGNING_ALLOWED' => 'NO'
    }
    
    # 设置子库 ===>
    # 文件类型
    fileType = "{swift,h,m,mm,cpp}"
    # 基础路径
    baseFilePath = "AxcBedrock/Classes"
    
    # 核心文件（不可或缺）
    core_files = [
    "#{baseFilePath}/Core/**/*.#{fileType}",
    "#{baseFilePath}/Utils/**/*.#{fileType}",
    "#{baseFilePath}/Enum/**/*.#{fileType}",
    "#{baseFilePath}/Extension/SwiftLib/**/*.#{fileType}",
    "#{baseFilePath}/Extension/Foundation/**/*.#{fileType}"
    ]
    # 属性包装器文件
    wrapper_files = "#{baseFilePath}/Wrapper/**/*.#{fileType}"
    # 跨平台文件
    crossPlatform_files = "#{baseFilePath}/Extension/CrossPlatform/**/*.#{fileType}"
    # 其他库文件路径
    # 因为拆分更细化的子库属实没必要，如果使用子库的话上传至Repo还需要进一步校验
    # 于是改为文件路径导入方式
    #    _files = "#{baseFilePath}/Extension/xxxx/**/*.#{fileType}"
    avFoundation_files = "#{baseFilePath}/Extension/AVFoundation/**/*.#{fileType}"
    coreFoundation_files = "#{baseFilePath}/Extension/CoreFoundation/**/*.#{fileType}"
    coreGraphics_files = "#{baseFilePath}/Extension/CoreGraphics/**/*.#{fileType}"
    coreImage_files = "#{baseFilePath}/Extension/CoreImage/**/*.#{fileType}"
    coreLocation_files = "#{baseFilePath}/Extension/CoreLocation/**/*.#{fileType}"
    coreMedia_files = "#{baseFilePath}/Extension/CoreMedia/**/*.#{fileType}"
    coreText_files = "#{baseFilePath}/Extension/CoreText/**/*.#{fileType}"
    coreVideo_files = "#{baseFilePath}/Extension/CoreVideo/**/*.#{fileType}"
    localAuthentication_files = "#{baseFilePath}/Extension/LocalAuthentication/**/*.#{fileType}"
    mapKit_files = "#{baseFilePath}/Extension/MapKit/**/*.#{fileType}"
    quartzCore_files = "#{baseFilePath}/Extension/QuartzCore/**/*.#{fileType}"
    webKit_files = "#{baseFilePath}/Extension/WebKit/**/*.#{fileType}"
    
    
    #iOS平台
    s.ios.deployment_target = '10.0'
    
    # iOS平台文件
    ios_source_files =
    core_files +
    [
    "#{baseFilePath}/Extension/UIKit/**/*.#{fileType}", # 主要文件
    wrapper_files, # 属性包装器
    crossPlatform_files, # 跨平台
    avFoundation_files,
    coreFoundation_files,
    coreGraphics_files,
    coreImage_files,
    coreLocation_files,
    coreMedia_files,
    coreText_files,
    coreVideo_files,
    localAuthentication_files,
    mapKit_files,
    quartzCore_files,
    webKit_files
    ]
    s.ios.source_files = ios_source_files
    
    
    # macOS平台
    s.osx.deployment_target = '11.0'
    
    # macOS平台文件
    osx_source_files =
    core_files +
    [
    "#{baseFilePath}/Extension/AppKit/**/*.#{fileType}", # 主要文件
    wrapper_files, # 属性包装器
    crossPlatform_files, # 跨平台
    coreFoundation_files,
    coreGraphics_files,
    coreImage_files,
    coreLocation_files,
    coreMedia_files,
    coreText_files,
    coreVideo_files,
    quartzCore_files,
    webKit_files
    ]
    s.osx.source_files = osx_source_files
    
    # Core主模块
    s.subspec 'Core' do |c|
        c.source_files = core_files
    end
    
    # iOS平台
    s.subspec 'iOS' do |c|
        c.ios.source_files = ios_source_files
        c.dependency 'AxcBedrock/Core'
        c.pod_target_xcconfig = {
        }
    end
    
    # MacOS平台
    s.subspec 'macOS' do |c|
        c.osx.source_files = osx_source_files
        c.dependency 'AxcBedrock/Core'
        c.pod_target_xcconfig = {
        }
    end
end
