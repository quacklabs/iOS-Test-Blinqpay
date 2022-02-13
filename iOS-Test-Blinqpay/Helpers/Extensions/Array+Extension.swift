//
//  Array+Extension.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 12/02/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//
import Foundation

public extension Array {
    mutating func appendDistinct<S>(contentsOf newElements: S, where condition:@escaping (Element, Element) -> Bool) where S : Sequence, Element == S.Element {
        newElements.forEach { (item) in
            if !(self.contains(where: { (selfItem) -> Bool in
                return !condition(selfItem, item)
            })) {
                self.append(item)
            }
        }
    }
}
