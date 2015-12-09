#
# Be sure to run `pod lib lint DQNetworkKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DQNetworkKit"
  s.version          = "1.1.0"
  s.summary          = "DQNetworkKit is a API Lib"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
  DQNetworkKit是一个API网络请求库，易使用，易扩展
                       DESC

  s.homepage         = "https://github.com/jjjjjeffrey/DQNetworkKit"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "zengdaqian" => "314099323@qq.com" }
  s.source           = { :git => "https://github.com/jjjjjeffrey/DQNetworkKit.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'DQNetworkKit' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking', '~> 2.6.3'
  s.dependency 'UICKeyChainStore'
  s.dependency 'YYModel'
end
