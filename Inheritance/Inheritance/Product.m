//
//  Product.m
//  Inheritance
//
//  Created by Djuro Alfirevic on 4/29/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Product.h"

@implementation Product

#pragma mark - Designated Initializer

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        // Title
        if ([dictionary objectForKey:@"ARTICLE"]) {
            self.itemTitle = [dictionary objectForKey:@"ARTICLE"];
        } else if ([dictionary objectForKey:@"NAME"]) {
            self.itemTitle = [dictionary objectForKey:@"NAME"];
        }
        
        if ([dictionary objectForKey:@"TITLE"]) {
            self.itemTitle = [dictionary objectForKey:@"TITLE"];
        }
        
        // Price
        if ([dictionary objectForKey:@"PRICE_VALUE"]) {
            self.price = [[dictionary objectForKey:@"PRICE_VALUE"] floatValue];
        } else if ([dictionary objectForKey:@"PRICE"]) {
            self.price = [[dictionary objectForKey:@"PRICE"] floatValue];
        }
        
        // If ACTION_PRICE exists - that means that product is on action
        if ([dictionary objectForKey:@"ACTION_PRICE"]) {
            self.price = [[dictionary objectForKey:@"ACTION_PRICE"] floatValue];
        }
        
        // Image URL
        self.imageURL = [dictionary objectForKey:@"thumb300"];
        
        self.coordinates = CLLocationCoordinate2DMake(44.48, 20.27);
    }
    
    return self;
}

#pragma mark - Public API

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", self.itemTitle];
}

#pragma mark - Public API

- (UIImage *)mapImage {
    return [UIImage imageNamed:@"product.png"];
}

@end