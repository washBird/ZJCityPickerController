#
#  Be sure to run `pod spec lint ZJCityPickerViewController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "ZJCityPickerViewController"
  s.version      = "0.1"
  s.summary      = "china city picker controller"

  s.description  = <<-DESC
  					   中国城市选择控制器
               可以自定义外观和城市数据源
                   DESC

  s.homepage     = "https://github.com/washBird/ZJCityPickerController"
  s.license      = { :type => "MIT", :file => "LICENSE"}
  s.author       = { "zoujie" => "http://www.jianshu.com/u/53c30d50712c" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/washBird/ZJCityPickerController.git", :tag => "#{s.version}" }

  s.source_files = "ZJCityPickerViewController/ZJCityPickerViewController/*.{h,m}"
  s.resources    = "ZJCityPickerViewController/ZJCityPickerViewController/ZJCityPickerViewControllerSource.bundle"

end
