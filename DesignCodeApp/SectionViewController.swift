//
//  SectionViewController.swift
//  DesignCodeApp
//
//  Created by Roger Florat on 16/02/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit
import RealmSwift

class SectionViewController: UIViewController {
    
    // Outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var subheadVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var closeVisualEffectView: UIVisualEffectView!
    
    var section: Section!
    var sections: Results<Section>!
    var indexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = section.title
        captionLabel.text = section.caption
        bodyLabel.text = section.body
        coverImageView.image = UIImage(named: section.imageName)
        progressLabel.text = "\(indexPath.row + 1) / \(sections.count)"
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
