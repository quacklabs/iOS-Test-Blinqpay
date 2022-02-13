//
//  String+Extension.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 12/02/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import Foundation

public extension String {

    var length: Int {
        return self.count
    }

    func substring(_ from: Int, _ length: Int? = nil) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        return (length != nil && self.length > 0) ? String(self[fromIndex ..< self.index(fromIndex, offsetBy: length!)]) : String(self[fromIndex...])
    }
}
