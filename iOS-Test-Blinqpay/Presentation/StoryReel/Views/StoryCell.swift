//
//  StoryCell.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 11/02/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import UIKit

class StoryCell: UICollectionViewCell {
        
    
    static let identifier = "story"
    let text = UI.text(string: "{{name}}")
    
    lazy var image: UIImageView = {
        let image = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 48, height: 48)))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let bg = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 65, height: 65)))
    var border = CAShapeLayer()
    
    var stories: StoryGroup!
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         initView()
    }
         
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func initView() {
        self.addViews([bg, text])
        bg.addViews([image])
        text.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.backgroundColor = .white
        
        bg.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bg.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        
        image.anchor(top: bg.topAnchor, leading: bg.leadingAnchor, bottom: bg.bottomAnchor, trailing: bg.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        image.layer.cornerRadius = 17
        
        text.topAnchor.constraint(equalTo: bg.bottomAnchor, constant: 5).isActive = true
        text.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func configure(with data: StoryGroup) {
        
        if data.items.count > 0 {
            bg.layer.cornerRadius = 20
            let gradient = CAGradientLayer()
            gradient.frame =  CGRect(origin: CGPoint.zero, size: bg.frame.size)
            gradient.colors = [UIColor(hex: Color.purple).cgColor, UIColor(hex: Color.lightPurple).cgColor]

            border.lineWidth = 4
            border.path = UIBezierPath(roundedRect: bg.bounds.insetBy(dx: 2, dy: 2), cornerRadius: 17).cgPath
            border.strokeColor = UIColor.black.cgColor
            border.fillColor = UIColor.clear.cgColor
            border.lineDashPattern = (data.items.count > 1) ? [NSNumber(value: data.items.count), 4] : [1,1]
            gradient.mask = border
            
            bg.layer.addSublayer(gradient)
        }
        
//        self.stories = data.items
//        guard let url = URL(string: stories.last!.url) else {
//            return
//        }
//        ImageLoader.shared.loadImage(from: url) { [weak self] (image) in
//            DispatchQueue.main.async {
//                self?.cover.image = image
//            }
//        }
//        self.title.text = "Username"
        self.stories = data
        image.image = UIImage(named: "dummy_img")!
        layer.cornerRadius = 4
        clipsToBounds = false
        layer.masksToBounds = true
        setNeedsLayout()
        setNeedsDisplay()
    }
//
       
//    func render(collection: [Story]) {
//        image.contentMode = .scaleAspectFit
//        image.image = UIImage(named: "dummy_img")!
//        self.setNeedsDisplay()
//    }
}
