//
//  MoreViewController.swift
//  DesignCodeApp
//
//  Created by Roger Florat on 19/02/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit
import MKRingProgressView

class MoreViewController: UIViewController {

    @IBOutlet weak var progress1View: MKRingProgressView!
    @IBOutlet weak var progress2View: MKRingProgressView!
    @IBOutlet weak var progress3View: MKRingProgressView!
    
    @IBOutlet weak var progress1Label: UILabel!
    @IBOutlet weak var progress2Label: UILabel!
    @IBOutlet weak var progress3Label: UILabel!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let progress = [72,56, 22]
        
        progress1Label.animateTo(progress[0])
        progress2Label.animateTo(progress[1])
        progress3Label.animateTo(progress[2])
        
        progress1View.animateTo(progress[0])
        progress2View.animateTo(progress[1])
        progress3View.animateTo(progress[2])
        
    }

    @IBAction func safariButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "More to Web", sender: "https://designcode.io")
    }
    
    @IBAction func communityButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "More to Web", sender: "https://spectrum.chat/design-code")
    }
    
    @IBAction func twitterHandleTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "More to Web", sender: "https://twitter.com/mengto")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "More to Web" {
            
            let toNav = segue.destination as! UINavigationController
            let toVC = toNav.viewControllers.first! as! WebViewController
            
            toVC.urlString = sender as! String
        }
    }
}

extension MKRingProgressView {
    
    func animateTo(_ number : Int) {
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        
        self.progress = Double(number) / 100
        
        CATransaction.commit()
    }
    
}










