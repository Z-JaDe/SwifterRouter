//
//  Router.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/19.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

public protocol RouterCompatible {
    func createNavCon(_ rootVC: UIViewController) -> UINavigationController
}
import UIKit
/// ZJaDe: 路由器管理
public struct Router {
    /// ZJaDe: 路线类型
    public enum ShowType {
        case none
        case push
        case reset
        case present
        case showPresent
        case popAndPush(popCount: Int)
    }
    public let showType: ShowType
    public let currentNavC: UINavigationController
    public init(_ currentNavC: UINavigationController) {
        self.currentNavC = currentNavC
        self.showType = .none
    }
    private init(_ currentNavC: UINavigationController, _ showType: ShowType) {
        self.currentNavC = currentNavC
        self.showType = showType
    }
    private func map(showType: ShowType) -> Router {
        return Router(currentNavC, showType)
    }
}
// MARK: - pop
extension Router {
    @discardableResult
    public func popTo<T: UIViewController>(_ VCType: T.Type, animated: Bool = true) -> Bool {
        return currentNavC.popTo(VCType, animated: animated)
    }
    public func pop(count: Int, animated: Bool = true) {
        currentNavC.pop(count: count, animated: animated)
    }
    public func popToRoot(animated: Bool = true) {
        currentNavC.popToRootViewController(animated: animated)
    }
}
// MARK: - push
extension Router {
    public func push(_ routeUrl: RouteUrlType, animated: Bool = true) {
        let router = map(showType: .push)
        DispatchQueue.main.async {
            guard let viewCon = router.parse(routeUrl) else { return }
            router.currentNavC.pushViewController(viewCon, animated: animated)
        }
    }
}
// MARK: - reset
extension Router {
    public func resetPush(_ routeUrl: RouteUrlType, animated: Bool) {
        reset([routeUrl], animated: animated)
    }
    public func reset(_ routeUrls: [RouteUrlType], animated: Bool) {
        let router = map(showType: .reset)
        DispatchQueue.main.async {
            guard let viewCons = router.parse(routeUrls) else { return }
            router.currentNavC.setViewControllers(viewCons, animated: animated)
        }
    }
}
// MARK: - popAndPush
extension Router {
    public func popAndPush(_ routeUrl: RouteUrlType, popCount: Int = 1, animated: Bool = true) {
        let router = map(showType: .popAndPush(popCount: popCount))
        DispatchQueue.main.async {
            guard let viewCon = router.parse(routeUrl) else { return }
            router.currentNavC.popAndPush(count: popCount, pushVC: viewCon, animated: animated)
        }
    }
    // MARK: L popToVCAndPush
    public func popToRootVCAndPush(_ routeUrl: RouteUrlType) {
        let count = currentNavC.viewControllers.count - 1
        popAndPush(routeUrl, popCount: count)
    }
    public func popToVCAndPush<T: UIViewController>(to VCType: T.Type, _ routeUrl: RouteUrlType) -> Bool {
        if let index = currentNavC.viewControllers.lazy.reversed().enumerated().first(where: {$0.element is T})?.offset {
            let count = index + 1
            popAndPush(routeUrl, popCount: count)
            return true
        } else {
            return false
        }
    }
}

// MARK: - present
extension Router {
    public func present(_ routeUrl: RouteUrlType, animated: Bool = true, completion: (() -> Void)? = nil) {
        let router = map(showType: .present)
        DispatchQueue.main.async {
            guard let tempViewCon = router.parse(routeUrl) else { return }
            let viewCon: UINavigationController = (tempViewCon as? UINavigationController)
                ?? (router as? RouterCompatible)?.createNavCon(tempViewCon)
                ?? UINavigationController(rootViewController: tempViewCon)

            if viewCon.presentingViewController == nil {
                router.currentNavC.present(viewCon, animated: animated, completion: completion)
            } else {
                assertionFailure("当前控制器已经present")
            }
        }
    }
}
// MARK: - showPresent
extension Router {
    public func showPresent(_ routeUrl: RouteUrlType, animated: Bool = true, completion: (() -> Void)? = nil) {
        let router = map(showType: .showPresent)
        DispatchQueue.main.async {
            guard let viewCon = router.parse(routeUrl) else { return }
            if viewCon.presentingViewController == nil {
                router.currentNavC.present(viewCon, animated: animated, completion: completion)
            } else {
                assertionFailure("当前控制器已经present")
            }
        }
    }
}
// MARK: - 解析routeUrl
extension Router {
    public func parse(_ routeUrl: RouteUrlType) -> UIViewController? {
        endEditing()
        guard let viewController = routeUrl.createViewCon(self) else {
            assertionFailure("跳转失败\(routeUrl)")
            return nil
        }
        return viewController
    }
    public func parse(_ routeUrls: [RouteUrlType]) -> [UIViewController]? {
        endEditing()
        guard let viewControllers = routeUrls.map({$0.createViewCon(self)}) as? [UIViewController] else {
            assertionFailure("跳转失败\(routeUrls)")
            return nil
        }
        return viewControllers
    }

    private func endEditing() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
}
