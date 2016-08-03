//
//  AsyncImageView.swift
//  VestiS
//
//  Created by Djuro Alfirevic on 8/3/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

import UIKit

class AsyncImageView: UIImageView {

    // MARK: - Properties
    var imageURL: String? {
        didSet {
            if let imageURL = imageURL {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
                    if let url = NSURL(string: imageURL) {
                        if let data = NSData(contentsOfURL: url) {
                            if let image = UIImage(data: data) {
                                dispatch_async(dispatch_get_main_queue(), {
                                    self.image = image
                                })
                            }
                        }
                    }
                })
            }
        }
    }
}