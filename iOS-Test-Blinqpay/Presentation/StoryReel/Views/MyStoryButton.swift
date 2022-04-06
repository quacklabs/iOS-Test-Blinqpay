//
//  MyStoryButton.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 25/03/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import UIKit

class MyStoryButton: UIView {
    
    var stories: [Story]?
    let text = UI.text(string: "My Story")
    
    lazy var image: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 17
        image.clipsToBounds = true
        return image
    }()
    
    var add_button: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hex: Color.purple)
        btn.layer.cornerRadius = 6.5
        btn.setImage(UIImage(named: "add")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.imageView?.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let bg = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 65, height: 65)))
    
    let border = CAShapeLayer()
    
    init() {
        super.init(frame: .zero)
        
        self.addViews([bg, text, add_button])
        bg.addViews([image])
        text.translatesAutoresizingMaskIntoConstraints = false
        
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.backgroundColor = .white
        text.textAlignment = .center

        
        bg.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 5, left: 8, bottom: 0, right: 8))
        
        image.anchor(top: bg.topAnchor, leading: bg.leadingAnchor, bottom: bg.bottomAnchor, trailing: bg.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        
        text.anchor(top: bg.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 2, right: 0))
        
//        text.topAnchor.constraint(equalTo: bg.bottomAnchor, constant: 8).isActive = true
//        text.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        add_button.rightAnchor.constraint(equalTo: bg.rightAnchor, constant: 1.5).isActive = true
        add_button.bottomAnchor.constraint(equalTo: bg.bottomAnchor, constant: 1.5).isActive = true
        
        add_button.heightAnchor.constraint(equalToConstant: 18).isActive = true
        add_button.widthAnchor.constraint(equalToConstant: 18).isActive = true
        add_button.layer.cornerRadius = 6.5
        
        bg.layer.cornerRadius = 20
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: bg.frame.size)
        gradient.colors = [UIColor(hex: Color.purple).cgColor, UIColor(hex: Color.lightPurple).cgColor]

        
        border.lineWidth = 4
        border.path = UIBezierPath(roundedRect: bg.bounds.insetBy(dx: 2, dy: 2), cornerRadius: 17).cgPath
        border.strokeColor = UIColor.black.cgColor
        border.fillColor = UIColor.clear.cgColor
        gradient.mask = border
        
        bg.layer.addSublayer(gradient)
        
        image.image = UIImage(named: "dummy_img")!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(collection: [Story]) {
        
        
        
        
//        if self.stor
//        shape.lineDashPattern = [4,2] as [NSNumber]
        self.setNeedsDisplay()
    }
}

