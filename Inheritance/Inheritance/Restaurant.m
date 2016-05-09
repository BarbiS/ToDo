//
//  Restaurant.m
//  Inheritance
//
//  Created by Djuro Alfirevic on 5/9/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

#pragma mark - Designated Initializer

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.itemTitle = dictionary[@"name"];
        self.desc = dictionary[@"location"][@"address"];
        
        self.coordinates = CLLocationCoordinate2DMake([dictionary[@"location"][@"lat"] floatValue], [dictionary[@"location"][@"lng"] floatValue]);
    }
    
    return self;
}

#pragma mark - Public API

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", self.itemTitle];
}

#pragma mark - Public API

- (UIImage *)mapImage {
    return [UIImage imageNamed:@"restaurant.png"];
}

@end