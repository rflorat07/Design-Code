//
//  UILabel+Animate.swift
//  DesignCodeApp
//
//  Created by Roger Florat on 21/02/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

extension UILabel {
    func animateTo(_ number : Int) {
        
        guard number > 0 else { return }
        
        let now = DispatchTime.now()
        
        for index in 0...number {
            let milliseconds = 10 * index
            let deadLine : DispatchTime = now + .milliseconds(milliseconds)
            
            DispatchQueue.main.asyncAfter(deadline: deadLine) {
                self.text = "\(index)%"
            }
        }
    }
}
