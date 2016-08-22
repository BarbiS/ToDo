//
//  ViewController.m
//  XIB
//
//  Created by Djuro Alfirevic on 8/22/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "ViewController.h"
#import "CellOneTableViewCell.h"
#import "CellTwoTableViewCell.h"

@interface ViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (nonatomic) NSInteger age;
@end

@implementation ViewController

#pragma mark - Properties

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
    }
    
    return _itemsArray;
}

- (void)setAge:(NSInteger)age {
    if (age < 18) {
        _age = 20;
    } else {
        _age = age;
    }
}

#pragma mark - Private API

- (void)methodA {
    NSLog(@"Calling methodB");
    [self methodB];
}

- (void)methodB {
    NSLog(@"Calling methodA");
    [self methodA];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.itemsArray addObject:@"One"];
    [self.itemsArray addObject:@"Two"];
    [self.itemsArray addObject:@"Three"];
    
    self.age = 14;
    NSLog(@"%ld", self.age);
    
    // Infinite loop
    //[self methodA];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *string = self.itemsArray[indexPath.row];
    
    if (indexPath.row == 0) {
        CellOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellOne"];
        if (!cell) {
            cell = (CellOneTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"CellOneTableViewCellPad" owner:nil options:nil] firstObject];
        }
        
        cell.titleLabel.text = string;
        
        return cell;
    }
    
    CellTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellTwo"];
    if (!cell) {
        cell = (CellTwoTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CellTwoTableViewCell class]) owner:nil options:nil] firstObject];
    }
    
    cell.titleLabel.text = string;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200.0f;
    }
    
    return 44.0f;
}

@end