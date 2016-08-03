//
//  Article.swift
//  VestiS
//
//  Created by Djuro Alfirevic on 8/3/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

import UIKit

class Article: NSObject {

    // MARK: - Properties
    var title: String?
    var desc: String?
    var imageURL: String?
    var link: String?
    
    // MARK: - Designated Initializer
    convenience init(dictionary: NSDictionary) {
        self.init()
        
        if let title = dictionary["title"] {
            self.title = title as? String
        }
        
        if let desc = dictionary["description"] {
            self.desc = desc as? String
        }
        
        if let imageURL = dictionary["imageUrl"] {
            self.imageURL = imageURL as? String
        }
        
        if let link = dictionary["url"] {
            self.link = link as? String
        }
    }
    
}