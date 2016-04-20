//
//  HomeViewController.m
//  TableView
//
//  Created by Djuro Alfirevic on 4/18/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "HomeViewController.h"
#import "AddViewController.h"
#import "DesignerTableViewCell.h"
#import "Designer.h"
#import "DataManager.h"

@interface HomeViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation HomeViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == MALE_GENDER) {
        return [[self.dataManager maleDesigners] count];
    }
    
    return [[self.dataManager femaleDesigners] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DesignerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.designer = [self.dataManager getCurrentDesignerForIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    AddViewController *toViewController = [storyboard instantiateViewControllerWithIdentifier:@"AddViewController"];
    
    if (indexPath.section == MALE_GENDER) {
        toViewController.designer = [self.dataManager getCurrentDesignerForIndexPath:indexPath];
    } else {
        toViewController.designer = [self.dataManager getCurrentDesignerForIndexPath:indexPath];
    }
    
    [self.navigationController pushViewController:toViewController animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == MALE_GENDER) {
        return @"Male Designers";
    }
    
    return @"Female Designers";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Designer *designer = [self.dataManager getCurrentDesignerForIndexPath:indexPath];
        NSInteger index = [self.dataManager getIndexForDesigner:designer];
        
        [self.dataManager.itemsArray removeObjectAtIndex:index];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end