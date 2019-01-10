//
//  RouteUrlType.swift
//  AppExtension
//
//  Created by 郑军铎 on 2018/8/17.
//  Copyright © 2018年 ZJaDe. All rights reserved.
//

import UIKit

public protocol RouteUrlType {
    func createViewCon(_ router: Router) -> UIViewController?
}
/// ZJaDe: 如果使用类的方式写 可以继承BaseRoute
open class BaseRoute: RouteUrlType {
    public typealias ClosureType = (Router) -> UIViewController?
    private let closure: ClosureType
    public init(_ closure: @escaping ClosureType) {
        self.closure = closure
    }
    open func createViewCon(_ router: Router) -> UIViewController? {
        return self.closure(router)
    }
}
/// ZJaDe: 也可以遵循协议后 直接返回UIViewController
extension RouteUrlType where Self: UIViewController {
    public func createViewCon(_ router: Router) -> UIViewController? {
        return self
    }
}
/** ZJaDe: 使用枚举的方式写
enum Route_Mine {
    case setting
}
extension Route_Mine: RouteUrlType {
    func createViewCon(_ router: Router) -> UIViewController? {
        switch self {
        case .setting:
            return SettingViewController()
        }
    }
}
*/
