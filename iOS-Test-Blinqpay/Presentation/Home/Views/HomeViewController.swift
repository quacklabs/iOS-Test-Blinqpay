//
//  HomeViewController.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 11/02/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let storiesViewModel = StoriesViewModel()
    
    lazy var storyView: StoryReel = {
        let reel = StoryReel(viewModel: storiesViewModel)
        reel.translatesAutoresizingMaskIntoConstraints = false
        return reel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        self.title = "Stories"
        self.view.addSubview(storyView)
        
        storyView.anchor([.top, .left, .right], to: view.safeAreaLayoutGuide)
        storyView.heightAnchor.constraint(equalToConstant: 100).isActive = true

//        viewModel.getStories(start: 1)
        storyView.load()
    }
}

//
//extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 0 //self.viewModel.users.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCell.identifier, for: indexPath) as? StoryCell else {
//            return UICollectionViewCell()
//        }
////        if self.viewModel.users.count > 0 {
////            let user = self.viewModel.users[indexPath.row]
////            guard let stories = self.viewModel.stories[user] else {
////                return UICollectionViewCell()
////            }
////            cell.configure(with: stories)
////        }
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = CGFloat(UIScreen.main.bounds.width - 26) / 2
//           return CGSize(width: width, height: 200)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        if self.viewModel.users.count > 0 {
////            let view = StoryViewController(viewModel: self.viewModel)
////            self.navigationController?.pushViewController(view, animated: true)
////        }
//    }
//}
