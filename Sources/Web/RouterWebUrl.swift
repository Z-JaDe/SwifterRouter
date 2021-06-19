//
//  RouterWebUrl.swift
//  Base
//
//  Created by ZJaDe on 2018/6/21.
//  Copyright © 2018年 ZJaDe. All rights reserved.
//
// ZJaDe: 解析webUrl 跳转
import Foundation
public struct RouterWebUrl {
    public let scheme: String
    public let host: String
    public let path: String
    public var params: [String: String] = [: ]

    public var pathArr: [String] {
        return self.path.split(separator: "/").filter {$0.count > 0}.map(String.init)
    }

    public let components: URLComponents
    public let urlStr: String
    public init?(_ urlStr: String) {
        let urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? urlStr
        guard let components = URLComponents(string: urlStr) else {
            return nil
        }
        self.urlStr = urlStr
        self.components = components
        self.scheme = components.scheme ?? ""
        self.host = components.host ?? ""
        self.path = components.path
        components.queryItems?.forEach({ (item) in
            self.params[item.name] = item.value?.removingPercentEncoding ?? item.value
        })
    }
}
/*
 extension Router {
     public func parseUrl(_ urlStr: String) {
         guard let routerUrl = RouterWebUrl(urlStr) else {
             return
         }
         guard let module = routerUrl.pathArr.first else {
             return
         }
         let appRouterItem = AppRouterItem(module)
         if let appRouterItem = appRouterItem as? RouterUrlConverterProtocol {
             appRouterItem.decode(routerUrl)
         }
     }
 }
 */
