#
# Be sure to run `pod lib lint FileBrowser.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FileBrowser'
  s.version          = '0.1.0'
  s.summary          = 'iOS文件浏览器'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
iOS文件浏览器，用于浏览沙盒文件列表
                       DESC

  s.homepage         = 'https://github.com/yizhaorong/FileBrowser'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yizhaorong' => '243653385@qq.com' }
  s.source           = { :git => 'https://github.com/yizhaorong/FileBrowser.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'FileBrowser/Classes/**/*'
  
   s.resource_bundles = {
     'FileBrowser' => ['FileBrowser/Assets/*']
   }

   s.public_header_files = 'FileBrowser/Classes/FBFileBrowerViewController.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Masonry'
end
