//
//  ViewController.m
//  Viber
//
//  Created by Djuro Alfirevic on 4/19/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "ViewController.h"
#import "MessageTableViewCell.h"
#import "Message.h"

@interface ViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UITextField *messageTextField;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@end

@implementation ViewController

#pragma mark - Properties

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
    }
    
    return _itemsArray;
}

#pragma mark - Actions

- (IBAction)addButtonTapped {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message"
                                                                             message:@"Please enter your message:"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        self.messageTextField = textField;
    }];
    
    // OK
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSInteger senderType = [self getRandomNumberBetween:0 to:1];
        
        Message *message = [[Message alloc] initWithText:self.messageTextField.text andSenderType:senderType];
        
        //[self.tableView reloadData];
        [self.tableView beginUpdates];
        
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.itemsArray.count inSection:0]]
                              withRowAnimation:UITableViewRowAnimationBottom];
        [self.itemsArray addObject:message];
        
        [self.tableView endUpdates];
    }]];
    
    // Cancel
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}]];
    
    [self presentViewController:alertController animated:YES completion:NULL];
}

#pragma mark - Actions

- (CGRect)rectForText:(NSString *)text withSize:(CGSize)size withFont:(UIFont *)font {
    CGRect textRect = [text boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    
    return textRect;
}

- (NSInteger)getRandomNumberBetween:(NSInteger)from to:(NSInteger)to {
    return (NSInteger)from + arc4random() % (to - from + 1);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = [self.itemsArray objectAtIndex:indexPath.row];
    
    // Choose the right cell
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeCell"];
    if (message.senderType == HIM_SENDER) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"HimCell"];
    }
    
    cell.message = [self.itemsArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = [self.itemsArray objectAtIndex:indexPath.row];
    
    CGRect textRect = [self rectForText:message.text
                               withSize:CGSizeMake(self.view.frame.size.width/2, INT_MAX)
                               withFont:[UIFont fontWithName:@"AvenirNext-Regular" size:14.0]];
    
    return textRect.size.height + 70.0f;
}

@end