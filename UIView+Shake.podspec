Pod::Spec.new do |s|
  s.name         = "UIView+Shake"
  s.version      = "1.1.1"
  s.summary      = "UIView category that adds a shake animation like the password field of the OSX login screen."
  s.homepage     = "https://github.com/andreamazz/UIView-Shake"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Andrea Mazzini" => "andrea.mazzini@gmail.com" }
  s.source       = { :git => "https://github.com/andreamazz/UIView-Shake.git", :tag => s.version }
  s.platform     = :ios, '7.0'
  s.source_files = 'Source', '*.{h,m}'
  s.requires_arc = true
end
