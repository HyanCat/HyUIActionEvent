
Pod::Spec.new do |s|
  s.name             = "HyUIActionEvent"
  s.version          = "0.1.0"
  s.summary          = "A Respond Chain Tool for UIResponder."
  s.license          = { :type => 'MIT', :file => 'LICENSE' }

  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/HyanCat/HyUIActionEvent"
  s.license          = 'MIT'
  s.author           = { "HyanCat" => "hyancat@live.cn" }
  s.source           = { :git => "https://github.com/HyanCat/HyUIActionEvent.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'HyUIActionEvent/**/*.{h,m}'
  s.public_header_files = 'HyUIActionEvent/**/*.h'
  
end
