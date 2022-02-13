//
//  StoryViewController.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 12/02/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class StoryViewController: UIViewController {
    
    var pageViewController : UIPageViewController?
    var currentIndex : Int = 0
    var viewModel: StoriesViewModel!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    convenience init(viewModel: StoriesViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController = UIPageViewController()
        pageViewController!.dataSource = self
        pageViewController!.delegate = self
        
        
        let startingViewController: PreviewController = viewControllerAtIndex(index: currentIndex)!
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
        pageViewController!.view.frame = view.bounds
        
        addChild(pageViewController!)
        view.addSubview(pageViewController!.view)
        view.sendSubviewToBack(pageViewController!.view)
        pageViewController!.didMove(toParent: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            self.navigationController?.navigationBar.isHidden = false
        }
        
    }
    
    func viewControllerAtIndex(index: Int) -> PreviewController? {
        
        if self.viewModel.stories.count == 0 || index >= self.viewModel.stories.count {
            return nil
        }
 
        // Create a new view controller and pass suitable data.
        
        let user = self.viewModel.users[index]
        guard let stories = self.viewModel.stories[user] else {
            return nil
        }
        let vc = PreviewController(items: stories)
        vc.pageIndex = index
        currentIndex = index
        vc.view.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        vc.forwardTo.subscribe(with: self) { [weak self] (position) in
            vc.dismiss(animated: true, completion: { self?.move(to: position) })
        }
        return vc
    }
    
    // Navigate to next page
    func move(to position: Int) {
        guard let startingViewController = viewControllerAtIndex(index: position) else {
            return
        }
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
    }
}


extension StoryViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard var index = (viewController as? PreviewController)?.pageIndex else {
            return nil
        }
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index: index)
    }
    
    //2
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PreviewController).pageIndex
        if index == NSNotFound {
            return nil
        }
        index += 1
        if (index == self.viewModel.stories.count) {
            return nil
        }
        return viewControllerAtIndex(index: index)
    }
}
