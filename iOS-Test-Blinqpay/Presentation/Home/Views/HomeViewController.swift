//
//  HomeViewController.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 11/02/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var viewModel: StoriesViewModel!
    
    lazy var storyView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let items = UICollectionView(frame: .zero, collectionViewLayout: layout)
        items.register(StoryCell.self, forCellWithReuseIdentifier: StoryCell.identifier)
        items.translatesAutoresizingMaskIntoConstraints = false
        items.isUserInteractionEnabled = true
        items.backgroundColor = .white
        return items
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Stories"
        self.view.addSubview(storyView)
        
        NSLayoutConstraint.activate([
            storyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            storyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            storyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            storyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        storyView.delegate = self
        storyView.dataSource = self
        
        viewModel.load.subscribe(with: self) {
            self.storyView.reloadData()
        }
        viewModel.getStories(start: 1)
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCell.identifier, for: indexPath) as? StoryCell else {
            return UICollectionViewCell()
        }
        if self.viewModel.users.count > 0 {
            let user = self.viewModel.users[indexPath.row]
            guard let stories = self.viewModel.stories[user] else {
                return UICollectionViewCell()
            }
            cell.configure(with: stories)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat(UIScreen.main.bounds.width - 26) / 2
           return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.viewModel.users.count > 0 {
            let user = self.viewModel.users[indexPath.row]
            guard let stories = self.viewModel.stories[user] else {
                return
            }
            let view = StoryViewController(viewModel: self.viewModel)
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
}
