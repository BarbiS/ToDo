//
//  ArticleTableViewCell.swift
//  VestiS
//
//  Created by Djuro Alfirevic on 8/3/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var asyncImageView: AsyncImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var article: Article? {
        didSet {
            if let title = article?.title {
                titleLabel.text = title
            }
            
            if let url = article?.imageURL {
                asyncImageView.imageURL = url
            }
        }
    }
    
}