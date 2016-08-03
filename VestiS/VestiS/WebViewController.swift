//
//  WebViewController.swift
//  VestiS
//
//  Created by Djuro Alfirevic on 8/3/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    // MARK: - Properties
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    var article: Article?
    
    // MARK: - Actions
    @IBAction func backButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let link = self.article?.link {
            if let url = NSURL(string: link) {
                let request = NSURLRequest(URL: url)
                self.webView.loadRequest(request)
            }
        }
    }
    
    // MARK: - UIWebViewDelegate
    func webViewDidStartLoad(webView: UIWebView) {
        self.spinnerView.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.spinnerView.stopAnimating()
    }

}