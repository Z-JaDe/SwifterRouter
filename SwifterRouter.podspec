Pod::Spec.new do |s|
    s.name             = "SwifterRouter"
    s.version          = "1.0.0"
    s.summary          = "Router"
    s.description      = <<-DESC
    Swift方式的路由跳转，支持枚举、结构体、类
    DESC
    s.homepage         = "https://github.com/Z-JaDe"
    s.license          = "MIT"
    s.author           = { "ZJaDe" => "zjade@outlook.com" }
    s.source           = { :git => "https://github.com/Z-JaDe/SwifterRouter.git", :tag => s.version.to_s }
    
    s.requires_arc          = true
    
    s.ios.deployment_target = '9.0'
    s.frameworks            = "Foundation"
    s.swift_version         = "5.0"

    s.source_files          = "Sources/**/*.{swift}"
end
