Pod::Spec.new do |s|
  s.name         = "XHPayKit"
  s.version      = "1.0.3"
  s.summary      = "不用官方SDK实现微信、支付宝支付."
  s.homepage     = "https://github.com/CoderZhuXH/XHPayKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Zhu Xiaohui" => "977950862@qq.com"}
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/CoderZhuXH/XHPayKit.git", :tag => s.version }
  s.source_files = "XHPayKit", "*.{h,m}"
  s.requires_arc = true
end
