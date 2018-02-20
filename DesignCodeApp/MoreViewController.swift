//
//  MoreViewController.swift
//  DesignCodeApp
//
//  Created by Roger Florat on 19/02/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
