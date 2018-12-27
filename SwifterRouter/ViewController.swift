//
//  ViewController.swift
//  SwifterRouter
//
//  Created by 郑军铎 on 2018/12/27.
//  Copyright © 2018 zjade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.randomColor()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        router().push(Route_Test.test1)
    }

}
extension UIColor {
    public static func randomColor(_ randomAlpha: Bool = false) -> UIColor {
        let randomRed = CGFloat.random()
        let randomGreen = CGFloat.random()
        let randomBlue = CGFloat.random()
        let alpha = randomAlpha ? CGFloat.random() : 1.0
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }
}
extension FloatingPoint {
    public static func random(min: Self = 0, max: Self = 1) -> Self {
        let diff = max - min
        let rand = Self(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Self(RAND_MAX)) * diff) + min
    }
}
