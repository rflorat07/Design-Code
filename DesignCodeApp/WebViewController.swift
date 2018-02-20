//
//  WebViewController.swift
//  DesignCodeApp
//
//  Created by Roger Florat on 19/02/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    // Outlet
    @IBOutlet weak var webView: WKWebView!
    
    var urlString : String!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        webView.load(request)
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if webView.estimatedProgress == 1.0 {
                navigationItem.title = webView.title
            } else {
                navigationItem.title = "Loading..."
            }
        }
    }
    
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func acttionButtonTapped(_ sender: Any) {
        let activityItems = [urlString] as! Array<String>
        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityController.excludedActivityTypes = [.postToFacebook]
        
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func safariButtonTapped(_ sender: UIBarButtonItem) {
        UIApplication.shared.open(URL(string: urlString)!)
    }
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    @IBAction func reload(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
}
