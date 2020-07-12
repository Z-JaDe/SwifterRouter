Pod::Spec.new do |s|
    s.name             = "SwifterRouter"
    s.version          = "1.1.0"
    s.summary          = "Router"
    s.description      = <<-DESC
    Swift方式的路由跳转，支持枚举、结构体、类
    DESC
    s.homepage         = "https://github.com/Z-JaDe"
    s.license          = "MIT"
    s.author           = { "ZJaDe" => "zjade@outlook.com" }
    s.source           = { :git => "https://github.com/Z-JaDe/SwifterRouter.git", :tag => s.version.to_s }
    
    s.requires_arc          = true
    
    s.ios.deployment_target = '13.0'
    s.swift_versions        = '5.0','5.1','5.2','5.3'
    s.frameworks            = "Foundation"

    s.source_files          = "Sources/**/*.{swift}"
end
