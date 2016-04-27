//
//  ListViewController.m
//  Maps
//
//  Created by Djuro Alfirevic on 4/27/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "ListViewController.h"
#import "MapViewController.h"
#import "Location.h"

@interface ListViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (strong, nonatomic) Location *selectedLocation;
@end

@implementation ListViewController

#pragma mark - Properties

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
    }
    
    return _itemsArray;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    Location *london = [[Location alloc] initWithName:@"London" andCoordinates:CLLocationCoordinate2DMake(51.50, 0.12)];
    Location *moscow = [[Location alloc] initWithName:@"Moscow" andCoordinates:CLLocationCoordinate2DMake(55.75, 37.61)];
    
    [self.itemsArray addObject:london];
    [self.itemsArray addObject:moscow];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MapSegue"]) {
        MapViewController *toViewController = segue.destinationViewController;
        toViewController.location = self.selectedLocation;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Location *location = [self.itemsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = location.name;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedLocation = [self.itemsArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"MapSegue" sender:self];
}

@end