//
//  ArticlesViewController.m
//  Vesti
//
//  Created by Djuro Alfirevic on 4/26/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "ArticlesViewController.h"
#import "ArticleDetailsViewController.h"
#import "ArticleTableViewCell.h"
#import "Article.h"

static NSString *const ARTICLES_URL = @"http://www.brzevesti.net/api/news";

@interface ArticlesViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (strong, nonatomic) Article *selectedArticle;
@end

@implementation ArticlesViewController

#pragma mark - Properties

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
    }
    
    return _itemsArray;
}

#pragma mark - Private API

- (void)loadArticlesFromURL {
    dispatch_queue_t downloadQueue = dispatch_queue_create("ArticlesDownloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:ARTICLES_URL]];
        
        NSError *serializationError;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
        
        if (serializationError) {
            NSLog(@"%@", [serializationError localizedDescription]);
        }
        
        NSLog(@"%@", dictionary[@"news"]);
        
        for (NSDictionary *articleDictionary in dictionary[@"news"]) {
            Article *article = [[Article alloc] initWithDictionary:articleDictionary];
            [self.itemsArray addObject:article];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)loadArticles {
    Article *article = [[Article alloc] initWithTitle:@"ČITAJTE U KURIRU ŠEŠELJ SE NUDI: Vučiću, uzmi me za ministra finansija"
                                          description:@"Mogao bih da vodim finansije i da tu sredim stanje, a šta će nam Dačić, da služi samo za zajebanciju i lopovluk"
                                             imageURL:@"http://www.brzevesti.net/news/images/2.88a87314930295c8920d90535190cc85.jpg"
                                              andLink:@"http://www.kurir.rs/vesti/politika/seselj-se-nudi-vucicu-uzmi-me-za-ministra-finansija-clanak-2239535"];
    [self.itemsArray addObject:article];
    [self.tableView reloadData];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self loadArticlesFromURL];
}

#pragma mark - Segue management

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ArticleDetailsSegue"]) {
        ArticleDetailsViewController *toViewController = segue.destinationViewController;
        toViewController.article = self.selectedArticle;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.article = [self.itemsArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedArticle = [self.itemsArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"ArticleDetailsSegue" sender:self];
}

@end