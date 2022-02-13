//
//  PreviewController.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 12/02/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//
import UIKit
import AVFoundation
import AVKit
import CoreMedia
import Signals


class PreviewController: UIViewController {
    
    lazy var videoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var profileImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "user")!)
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var close: UIButton = {
       let btn = UIButton()
        btn.imageView?.image = UIImage(named:"close")!
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var pageIndex : Int = 0
    private var items: [Story]!
    var progress: SegmentedProgressBar!
    var player: AVPlayer!
    let forwardTo = Signal<(Int)>()
    var observer: NSKeyValueObservation?
    
    lazy var spinner:  UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        return spinner
    }()
    
    convenience init(items: [Story]) {
        self.init(nibName: nil, bundle: nil)
        self.items = items
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progress = SegmentedProgressBar(numberOfSegments: items.count, duration: 5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.topColor = UIColor.white
        progress.bottomColor = UIColor.white.withAlphaComponent(0.25)
        progress.padding = 2
        progress.isPaused = true
        progress.currentAnimationIndex = 0
        progress.duration = getDuration(at: 0)
        
        view.addViews([imageView, videoView, progress, close])
        
        imageView.anchor([.all], to: view.safeAreaLayoutGuide)
        videoView.anchor([.all], to: view.safeAreaLayoutGuide)
        close.anchor([.right, .top], to: view.safeAreaLayoutGuide, offset: UIEdgeInsets(top: 7, left:0, bottom:0, right: -10))
        close.heightAnchor.constraint(equalToConstant: 20).isActive = true
        close.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        progress.anchor([.top, .left, .right], to: view.safeAreaLayoutGuide, offset: UIEdgeInsets(top: 2, left: 10, bottom: 0, right: -10))
        progress.heightAnchor.constraint(equalToConstant: 3.5).isActive = true
        view.bringSubviewToFront(progress)
        view.bringSubviewToFront(close)
        
        progress.changed.subscribe(with: self) { [weak self] (index) in
            self?.observer?.invalidate()
            self?.playVideoOrLoadImage(index: index)
        }
        
        progress.finish.subscribe(with: self) {
            self.observer?.invalidate()
            if self.pageIndex == (self.items.count - 1) {
                self.dismiss(animated: true, completion: nil)
            }
            else {
                let index = self.pageIndex + 1
                self.forwardTo => (index)
            }
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOn(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        
        videoView.addGestureRecognizer(tapGesture)
        imageView.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(tapGesture)
        
        close.onTouchUpInside.subscribe(with: self) {
            self.dispose()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func tapOn(_ sender: UITapGestureRecognizer) {
        let center = UIScreen.main.bounds.width / 2
        let point = sender.location(in: self.view)
        
        if point.x > center {
            self.dispose()
            self.progress.skip()
        } else {
            self.dispose()
            self.progress.rewind()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIView.animate(withDuration: 0.8) {
            self.view.transform = .identity
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.progress.isPaused = true
            self.playVideoOrLoadImage(index: 0)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dispose()
    }
    
    private func dispose() {
        DispatchQueue.main.async {
            self.observer?.invalidate()
            self.progress.currentAnimationIndex = 0
            self.progress.cancel()
            self.progress.isPaused = true
            self.resetPlayer()
        }
        
    }
    
    // MARK: Private func
    private func getDuration(at index: Int) -> TimeInterval {
        var retVal: TimeInterval = 5.0
        if items[index].video == false {
            retVal = 5.0
        } else {
            guard let url = NSURL(string: items[index].url) as URL? else { return retVal }
            let asset = AVAsset(url: url)
            let duration = asset.duration
            retVal = CMTimeGetSeconds(duration)
        }
        return retVal
    }
    
    
    func playVideoOrLoadImage(index: Int) {
        self.view.addViews([spinner])
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.view.bringSubviewToFront(spinner)
        
        if items[index].video == false {
            progress.duration = 5
            self.imageView.isHidden = false
            self.videoView.isHidden = true
            guard let url = URL(string: items[index].url) else {
                return
            }
            self.imageView.image = nil
            ImageLoader.shared.loadImage(from: url) { (image) in
                DispatchQueue.main.async {
                    self.spinner.removeFromSuperview()
                    self.imageView.image = image
                    self.progress.play(index: index)
                }
            }
        } else {
            self.imageView.isHidden = true
            self.videoView.isHidden = false
            
            resetPlayer()
            guard let url = NSURL(string: items[index].url) as URL? else {return}
            let asset = AVAsset(url: url)
            let assetKeys = ["playable"]
            
            let playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: assetKeys)
            
            self.observer = playerItem.observe(\.status, options:  [.new, .old], changeHandler: { (playerItem, change) in
                if playerItem.status == .readyToPlay {
                    //Do your work here
                    let duration = asset.duration
                    let durationTime = CMTimeGetSeconds(duration)
                    
                    self.progress.duration = durationTime
                    
                    self.player.play()
                    self.spinner.removeFromSuperview()
                    self.progress.play(index: index)
                }
            })
            player = AVPlayer(playerItem: playerItem)
            
            let videoLayer = AVPlayerLayer(player: self.player)
            videoLayer.frame = view.bounds
            videoLayer.videoGravity = .resizeAspect
            self.videoView.layer.addSublayer(videoLayer)
        }
    }
    
    private func resetPlayer() {
        if player != nil {
            player.pause()
            player.replaceCurrentItem(with: nil)
            player = nil
        }
    }
    
    
}
