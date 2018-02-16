//
//  ViewController.swift
//  DesignCodeApp
//
//  Created by Roger Florat on 14/02/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    // Outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deviceImageView: UIImageView!
    @IBOutlet weak var playVisualView: UIVisualEffectView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var heroView: UIView!
    @IBOutlet weak var bookView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        titleLabel.alpha = 0
        deviceImageView.alpha = 0
        playVisualView.alpha = 0
        
        UIView.animate(withDuration: 1){
            self.titleLabel.alpha = 1
            self.deviceImageView.alpha = 1
            self.playVisualView.alpha = 1
        }
        
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        
        let urlString = "https://player.vimeo.com/external/235468301.hd.mp4?s=e852004d6a46ce569fcf6ef02a7d291ea581358e&profile_id=175"
        let url = URL(string: urlString)
        let player = AVPlayer(url: url!)
        let playerController = AVPlayerViewController()
        
        playerController.player = player
        
        present(playerController, animated: true)
        
        player.play()
    }
    
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        
        if offsetY < 0 {
            heroView.transform = CGAffineTransform(translationX: 0, y: offsetY)
            playVisualView.transform = CGAffineTransform(translationX: 0, y: -offsetY/3)
            titleLabel.transform = CGAffineTransform(translationX: 0, y: -offsetY/3)
            deviceImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/4)
            backgroundImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/5)
        }
    }
}

