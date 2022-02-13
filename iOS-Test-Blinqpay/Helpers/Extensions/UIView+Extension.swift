//
//  UIView+Extension.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 13/02/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import UIKit

extension UIView {
    
    func addViews(_ views: [UIView]) {
        for view in views  {
            self.addSubview(view)
        }
    }
    
    func anchor(_ edges: UIRectEdge, to layoutGuide: UILayoutGuide, offset: UIEdgeInsets? = nil) {
        if edges.contains(.top) || edges.contains(.all) {
            self.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: offset?.top ?? 0).isActive = true
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: offset?.bottom ?? 0).isActive = true
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: offset?.left ?? 0).isActive = true
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: offset?.right ?? 0).isActive = true
        }
    }
}
