#
# Be sure to run `pod lib lint StarsKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'StarsKit'
  s.version          = '0.1.0'
  s.summary          = 'StarsKit is a lightfull Swift library to simplify and configure your app rating workflow.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/smartnsoft/StarsKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Smart&Soft' => 'contact@smartnsoft.com' }
  s.source           = { :git => 'https://github.com/smartnsoft/StarsKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'StarsKit/Classes/**/*'

  s.resource_bundles = {
    'StarsKit' => ['StarsKit/Assets/StarsKit.bundle/*.lproj/*.strings', 'StarsKit/Assets/StarsKitImages.xcassets']
  }

  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Cosmos', '~> 15.0'
  s.dependency 'Extra', '~> 1.1'
  s.dependency 'Jelly', '~> 1.2'
end
