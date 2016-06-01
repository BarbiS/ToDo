//
//  SideMenuViewController.m
//  Fetcher
//
//  Created by Djuro Alfirevic on 6/1/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "SideMenuViewController.h"
#import "Fetcher.h"
#import "Article.h"
#import "Constants.h"

@interface SideMenuViewController() <UITableViewDataSource, UITableViewDelegate, FetcherDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@end

@implementation SideMenuViewController

#pragma mark - Properties

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
    }
    
    return _itemsArray;
}

#pragma mark - Private API

- (void)loadData {
    [[Fetcher sharedInstance] fetchDataFromURL:@"http://www.brzevesti.net/api/news" withCompletion:^(BOOL success, NSDictionary *dictionary, NSError *error)
    {
        if (success) {
            [self.itemsArray removeAllObjects];
            
            NSLog(@"%@", dictionary[@"news"]);
            
            for (NSDictionary *articleDictionary in dictionary[@"news"]) {
                Article *article = [[Article alloc] initWithDictionary:articleDictionary];
                [self.itemsArray addObject:article];
            }
            
            [self.tableView reloadData];
        } else {
            if (error) {
                NSLog(@"Error occured: %@", error.localizedDescription);
            }
        }
    }];
}

#pragma mark - View lifecycle

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserverForName:DATA_DOWNLOADED
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note)
     {
         if (note.object && [note.object isKindOfClass:[NSDictionary class]]) {
             NSDictionary *dictionary = (NSDictionary *)note.object;
             
             [self.itemsArray removeAllObjects];
             
             NSLog(@"%@", dictionary[@"news"]);
             
             for (NSDictionary *articleDictionary in dictionary[@"news"]) {
                 Article *article = [[Article alloc] initWithDictionary:articleDictionary];
                 [self.itemsArray addObject:article];
             }
             
             [self.tableView reloadData];
             
             // Inform user that news are downloaded
             //[[NSNotificationCenter defaultCenter] postNotificationName:OPEN_MENU_NOTIFICATION object:nil];
         } else {
             NSLog(@"Error occured");
         }
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. BLOCK
    //[self loadData];
    
    [[Fetcher sharedInstance] fetchDataFromURL:@"http://www.brzevesti.net/api/news"];
    // 2. NOTIFICATION
    [self registerForNotifications];
    
    // 3. DELEGATE
    //[Fetcher sharedInstance].delegate = self;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Article *article = [self.itemsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = article.title;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Article *article = [self.itemsArray objectAtIndex:indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CLOSE_MENU_NOTIFICATION object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_ARTICLE_NOTIFICATION object:article];
}

#pragma mark - FetcherDelegate

- (void)dataFetched:(NSDictionary *)dictionary {
    if (dictionary) {
        [self.itemsArray removeAllObjects];
        
        NSLog(@"%@", dictionary[@"news"]);
        
        for (NSDictionary *articleDictionary in dictionary[@"news"]) {
            Article *article = [[Article alloc] initWithDictionary:articleDictionary];
            [self.itemsArray addObject:article];
        }
        
        [self.tableView reloadData];
    } else {
        NSLog(@"Error occured");
    }
}

@end