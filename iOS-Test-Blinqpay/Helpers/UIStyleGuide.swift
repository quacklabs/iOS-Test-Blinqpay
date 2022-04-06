//
//  UIStyleGuide.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 25/03/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import UIKit

enum TextStyle {
    case normal
    case bold
    case itallic
    
    var weight: UIFont.Weight {
        switch self {
        case .normal:
            return .regular
        case .bold:
            return .bold
        case .itallic:
            return .light
        }
    }
}

enum TextColor {
    case primary
    case bold
    
    
    var dark: UIColor {
        switch self{
        case .primary:
            return UIColor(hex: "#4B4651")
        case .bold:
            return UIColor(hex: "#3B3B3B")
        }
    }
}

enum AppFont {
    case product_bold
    case roboto_medium
    case product
    case oswald_heavy
    var name: String {
        switch self {
        case .product:
            return "ProductSans-Regular"
        case .product_bold:
            return "ProductSans-Bold"
        default:
            return "ProductSans-Regular"
        }
    }
}

struct UI {
    
    static func text(string: String?, font: AppFont? = .product, style: TextStyle? = .normal, color: TextColor? = .primary, size: CGFloat? = 12) -> UILabel {
        let text = UILabel()
        let use_font = (style == .normal) ? UIFont(name: font!.name, size: size!)?.withWeight(style!.weight)  : UIFont(name: font!.name, size: size!)
        text.text = string
        text.font = use_font
        text.textColor = color?.dark
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }
}
