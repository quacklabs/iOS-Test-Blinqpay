//
//  StoryReel.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 24/03/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
//import RxDataSources

//
//protocol StoryCollection {
//    func render(collection: [Story])
//    var stories: [Story]? { get set}
//}

class StoryReel: UIView {
    
    let viewModel: StoriesViewModel!
    private let disposeBag = DisposeBag()
    
    lazy var carousel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 3, left: 5, bottom: 5, right: 5)
        
        let carousel = UICollectionView(frame: .zero, collectionViewLayout: layout)
        carousel.backgroundColor = .white
        carousel.register(StoryCell.self, forCellWithReuseIdentifier: StoryCell.identifier)
        return carousel
    }()
    
    lazy var my_story: MyStoryButton = {
        let btn = MyStoryButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
        
    init(viewModel: StoriesViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configure()
        bindData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addViews([my_story, carousel])
        
        my_story.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        my_story.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        my_story.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        my_story.widthAnchor.constraint(equalToConstant: 85).isActive = true
        
        carousel.anchor(top: topAnchor, leading: my_story.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        carousel.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func load() {
        viewModel.setupReel()
    }
    
    private func bindData() {
        viewModel.story_reel.bind(to: self.carousel.rx.items(cellIdentifier: StoryCell.identifier, cellType: StoryCell.self)) { (index, item, cell)  in
            
            cell.configure(with: item)
            
        }.disposed(by: disposeBag)
        
        
        self.carousel.rx.modelSelected(StoryGroup.self)
            .subscribe(onNext: { (story_group) in
                print("record: \(story_group)")
            }, onError: { (error) in
                print("error: \(error)")
            }).disposed(by: disposeBag)
        
//        self.carousel.rx.
    }
}

extension StoryReel: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height - 10
           return CGSize(width: 85, height: height)
    }
}
