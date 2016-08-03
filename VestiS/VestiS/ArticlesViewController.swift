//
//  ArticlesViewController.swift
//  VestiS
//
//  Created by Djuro Alfirevic on 8/3/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

import UIKit

let kArticlesURL = "http://www.brzevesti.net/api/news"

class ArticlesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var items:[Article] = []
    var selectedArticle: Article? {
        didSet {
            self.performSegueWithIdentifier("ArticleDetailsSegue", sender: self)
        }
    }
    
    // MARK: - Private API
    private func loadArticlesFromUrl() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            let url = NSURL(string: kArticlesURL)
            
            if let data = NSData(contentsOfURL: url!) {
                dispatch_async(dispatch_get_main_queue(), {
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions(rawValue: 0))
                        guard let dictionary = json as? NSDictionary else {
                            print("Not a Dictionary")
                            return
                        }
                        
                        if let array = dictionary["news"] as? NSArray {
                            for json in array {
                                self.items.append(Article(dictionary: json as! NSDictionary))
                            }
                            
                            self.tableView.reloadData()
                        }
                    } catch let error as NSError {
                        print("\(error.localizedDescription)")
                    }
                })
            }
        })
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.loadArticlesFromUrl()
    }
    
    // MARK: - Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ArticleDetailsSegue" {
            let toViewController = segue.destinationViewController as! ArticleDetailsViewController
            toViewController.article = self.selectedArticle
        }
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! ArticleTableViewCell
        
        cell.article = items[indexPath.row]
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.selectedArticle = items[indexPath.row]
    }

}