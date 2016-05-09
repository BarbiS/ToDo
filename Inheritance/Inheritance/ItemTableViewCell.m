//
//  ItemTableViewCell.m
//  Inheritance
//
//  Created by Djuro Alfirevic on 4/29/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "ItemTableViewCell.h"

@implementation ItemTableViewCell

#pragma mark - Properties

- (void)setItem:(Item *)item {
    _item = item;
    
    self.asyncImageView.imageURL = item.imageURL;
    self.titleLabel.text = item.title;
}

@end