//
//  ArticleDetailsViewController.swift
//  VestiS
//
//  Created by Djuro Alfirevic on 8/3/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

import UIKit

class ArticleDetailsViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var asyncImageView: AsyncImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    var article: Article?
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let article = self.article {
            self.asyncImageView.imageURL = article.imageURL
            self.titleLabel.text = article.title
            self.titleLabel.adjustsFontSizeToFitWidth = true
            self.descTextView.text = article.desc
        }
    }
    
    // MARK: - Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "WebSegue" {
            let toViewController = segue.destinationViewController as! WebViewController
            toViewController.article = self.article
        }
    }
    
}