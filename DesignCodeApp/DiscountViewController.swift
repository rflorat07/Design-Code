//
//  DiscountViewController.swift
//  DesignCodeApp
//
//  Created by Roger Florat on 21/02/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class DiscountViewController: UIViewController {

    
    @IBOutlet var panToClose: InteractionPanToClose!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        panToClose.setGestureRecognizer()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        panToClose.animateDialogAppear()
    }
}
