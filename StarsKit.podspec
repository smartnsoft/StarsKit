Pod::Spec.new do |s|
  s.name             = 'StarsKit'
  s.version          = '0.2.0'
  s.summary          = 'StarsKit is a Swift library to simplify, customize and configure your app rating workflow.'

  s.homepage         = 'https://github.com/smartnsoft/StarsKit'
  s.screenshots      = 'https://github.com/smartnsoft/StarsKit/blob/master/img/step_rate.png?raw=true', 'https://github.com/smartnsoft/StarsKit/blob/master/img/step_feedback.png?raw=true', 'https://github.com/smartnsoft/StarsKit/blob/master/img/step_store.png?raw=true'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Smart&Soft' => 'contact@smartnsoft.com' }
  s.source           = { :git => 'https://github.com/smartnsoft/StarsKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/smartnsoft'

  s.ios.deployment_target = '9.0'

  s.source_files = 'StarsKit/Classes/**/*'

  s.resources = [
    'StarsKit/Assets/*.lproj/*.strings',
    'StarsKit/Assets/StarsKitImages.xcassets'
    ]

  s.frameworks = 'UIKit'
  s.dependency 'Cosmos', '~> 15.0'
  s.dependency 'Extra/UIKit', '~> 1.1'
  s.dependency 'Jelly', '~> 1.2'
end
