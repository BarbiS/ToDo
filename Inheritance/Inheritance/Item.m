//
//  Item.m
//  Inheritance
//
//  Created by Djuro Alfirevic on 4/29/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Item.h"

@implementation Item

#pragma mark - Designated Initializer

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.itemTitle = dictionary[@"title"];
        self.desc = dictionary[@"description"];
        self.imageURL = dictionary[@"imageUrl"];
    }
    
    return self;
}

#pragma mark - Public API

- (NSString *)description {
    return self.desc;
}

- (UIImage *)mapImage {
    return nil;
}

#pragma mark - MKAnnotation

- (NSString *)title {
    return [self description];
}

- (CLLocationCoordinate2D)coordinate {
    return self.coordinates;
}

@end