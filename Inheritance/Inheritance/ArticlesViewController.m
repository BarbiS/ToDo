//
//  ArticlesViewController.m
//  Inheritance
//
//  Created by Djuro Alfirevic on 4/29/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "ArticlesViewController.h"
#import "ArticleTableViewCell.h"
#import "Article.h"

static NSString *const ARTICLES_URL = @"http://www.brzevesti.net/api/news";

@implementation ArticlesViewController

#pragma mark - Public API

- (void)loadData {
    [super loadData];
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("ArticlesDownloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:ARTICLES_URL]];
        
        NSError *serializationError;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
        
        if (serializationError) {
            NSLog(@"%@", [serializationError localizedDescription]);
        }
        
        for (NSDictionary *articleDictionary in dictionary[@"news"]) {
            Article *article = [[Article alloc] initWithDictionary:articleDictionary];
            [self.itemsArray addObject:article];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            [self.tableView reloadData];
        });
    });
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.item = [self.itemsArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    [self performSegueWithIdentifier:@"ArticleDetailsSegue" sender:self];
}

@end