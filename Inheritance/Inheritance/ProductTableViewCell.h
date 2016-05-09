//
//  ProductTableViewCell.h
//  Inheritance
//
//  Created by Djuro Alfirevic on 5/9/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "ItemTableViewCell.h"

@interface ProductTableViewCell : ItemTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end