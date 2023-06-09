#

Pod::Spec.new do |s|
  s.name             = 'SFUIKit'
  s.version          = '1.0'
  s.summary          = 'A short description of SFUIKit.'


  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
                        
  s.homepage         = 'https://github.com/JsonLiSir/SFUIkit.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '1026694246@qq.com' => '1026694246@qq.com' }
  s.source           = { :git => 'https://github.com/JsonLiSir/SFUIkit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'SFUIKit/Classes/**/*'
  
end
