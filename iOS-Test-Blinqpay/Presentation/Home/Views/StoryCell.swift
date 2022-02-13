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
    
    var stories: [Story]!
    
    lazy var cover: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    lazy var title: UILabel = {
        let txt = UILabel()
        txt.textColor = .white
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         initView()
    }
         
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func initView() {
        let backdrop = UIView()
        backdrop.backgroundColor = UIColor(hex: "333333").withAlphaComponent(0.7)
        backdrop.translatesAutoresizingMaskIntoConstraints = false
        backdrop.addSubview(title)
        
        self.addSubview(cover)
        self.addSubview(backdrop)
        NSLayoutConstraint.activate([
            cover.topAnchor.constraint(equalTo: topAnchor),
            cover.leadingAnchor.constraint(equalTo: leadingAnchor),
            cover.trailingAnchor.constraint(equalTo: trailingAnchor),
            cover.bottomAnchor.constraint(equalTo: bottomAnchor),
            backdrop.leadingAnchor.constraint(equalTo: leadingAnchor),
            backdrop.trailingAnchor.constraint(equalTo: trailingAnchor),
            backdrop.bottomAnchor.constraint(equalTo: bottomAnchor),
            backdrop.heightAnchor.constraint(equalToConstant: 40),
            title.topAnchor.constraint(equalTo: backdrop.topAnchor, constant: 4),
            title.leadingAnchor.constraint(equalTo: backdrop.leadingAnchor, constant: 10),
        ])
        self.bringSubviewToFront(backdrop)
        self.clipsToBounds = false
    }
    
    func configure(with data: [Story]) {
        self.stories = data
        guard let url = URL(string: stories.last!.url) else {
            return
        }
        ImageLoader.shared.loadImage(from: url) { [weak self] (image) in
            DispatchQueue.main.async {
                self?.cover.image = image
            }
        }
        self.title.text = "Username"
        layer.cornerRadius = 4
        clipsToBounds = false
        layer.masksToBounds = true
        setNeedsLayout()
        setNeedsDisplay()
    }
}
