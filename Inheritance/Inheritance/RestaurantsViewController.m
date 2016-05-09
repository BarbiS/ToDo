//
//  RestaurantsViewController.m
//  Inheritance
//
//  Created by Djuro Alfirevic on 5/9/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "RestaurantsViewController.h"
#import "RestaurantTableViewCell.h"
#import "Restaurant.h"

// Foursquare
#define kApiURL         @"https://api.foursquare.com/v2"
#define kClientID       @"N5AHSR4HE1CWBK5FZ0PU2E1GHU2FZYQSEQRQFOIHRBXRZP2I"
#define kClientSecret   @"1PIVJIRP0CFPV1QISSYI5JLE0JW0GLPCXMCWVJ4QUDPXY5PM"

@implementation RestaurantsViewController

#pragma mark - Public API

- (void)loadData {
    [super loadData];
    
    NSString *url = [NSString stringWithFormat:@"%@/venues/search?client_id=%@&client_secret=%@&v=%@&ll=%.2f,%.2f&categoryId=%@",
                     kApiURL,
                     kClientID,
                     kClientSecret,
                     @"20130815",
                     44.4,
                     20.27,
                     @"4bf58dd8d48988d116941735"];
    // Bars categoryID (Foursquare Category Archive - https://developer.foursquare.com/categorytree)
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("RestaurantsDownloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        NSError *serializationError;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
        
        NSLog(@"%@", dictionary[@"response"][@"venues"]);
        
        if (serializationError) {
            NSLog(@"%@", [serializationError localizedDescription]);
        }
        
        for (NSDictionary *articleDictionary in dictionary[@"response"][@"venues"]) {
            Restaurant *restaurant = [[Restaurant alloc] initWithDictionary:articleDictionary];
            [self.itemsArray addObject:restaurant];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            [self.tableView reloadData];
        });
    });
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.item = [self.itemsArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    [self performSegueWithIdentifier:@"RestaurantDetailsSegue" sender:self];
}

@end