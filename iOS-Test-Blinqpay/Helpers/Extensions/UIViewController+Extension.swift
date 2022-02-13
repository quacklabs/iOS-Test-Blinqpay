//
//  UIViewController+Extension.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 11/02/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrapInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
