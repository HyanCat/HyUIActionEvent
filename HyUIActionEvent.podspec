
Pod::Spec.new do |s|
  s.name             = "HyUIActionEvent"
  s.version          = "0.1.1"
  s.summary          = "An elegant way to handle UI action events based on UIResponder."
  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  s.description      = <<-DESC
  An elegant way to handle UI action events based on UIResponder, simply and powerful.
                       DESC

  s.homepage         = "https://github.com/HyanCat/HyUIActionEvent"
  s.license          = 'MIT'
  s.author           = { "HyanCat" => "hyancat@live.cn" }
  s.source           = { :git => "https://github.com/HyanCat/HyUIActionEvent.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.frameworks = 'Foundation', 'UIKit'

  s.default_subspec = 'Core'

  s.subspec 'Core' do |core|
    core.source_files = 'HyUIActionEvent/Classes/Core/*.{h,m}'
    core.public_header_files = 'HyUIActionEvent/Classes/Core/*.h'
  end

  s.subspec 'Transition' do |transition|
    transition.dependency 'HyUIActionEvent/Core'
    transition.source_files = 'HyUIActionEvent/Classes/Transition/*.{h,m}'
    transition.public_header_files = 'HyUIActionEvent/Classes/Transition/*.h'
  end

end
