//
//  ProductTableViewCell.m
//  Inheritance
//
//  Created by Djuro Alfirevic on 5/9/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "ProductTableViewCell.h"
#import "Product.h"

@implementation ProductTableViewCell

#pragma mark - Properties

- (void)setItem:(Item *)item {
    [super setItem:item];
    
    Product *p = (Product *)item;
    
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f", p.price];
}

@end