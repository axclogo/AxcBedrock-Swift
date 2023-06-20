#
#  Be sure to run `pod spec lint AxcAE_TabBar.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

    s.name         = "AxcBadrock"

    s.version      = "3.0.0"

    s.summary      = "集成了大量类扩展、基类、工具与控件的开发包，能达成快速开发的基础，故名为“基岩”"

    s.ios.deployment_target = '10.0'

    s.homepage     = "https://gitee.com/axc/axc-badrock-swift"

    s.license              = { :type => "MIT", :file => "LICENSE" }

    s.author             = { "赵新" => "axclogo@163.com" }

    s.social_media_url   = "http://www.cnblogs.com/axclogo/"

    s.source       = { :git => "https://gitee.com/axc/axc-badrock-swift.git", :tag => s.version }

    s.source_files  = 'AxcBadrock-Swift/AxcBadrock/**/*.{swift}'
    s.resource     = 'AxcBadrock-Swift/AxcBadrock/Resources/AxcBadrock.bundle'
 
    s.requires_arc = true


end