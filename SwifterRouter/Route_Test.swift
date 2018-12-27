//
//  Route_Test.swift
//  SwifterRouter
//
//  Created by 郑军铎 on 2018/12/27.
//  Copyright © 2018 zjade. All rights reserved.
//

import UIKit

enum Route_Test {
    case test1
    case test2
}
extension Route_Test: RouteUrlType {
    func createViewCon(_ manager: Router) -> UIViewController? {
        switch self {
        case .test1:
            return ViewController()
        case .test2:
            return ViewController()
        }
    }
}
