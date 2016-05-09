//
//  Article.m
//  Inheritance
//
//  Created by Djuro Alfirevic on 4/29/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Article.h"

@implementation Article

#pragma mark - Designated Initializer

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super initWithDictionary:dictionary]) {
        self.link = dictionary[@"url"];
        self.coordinates = CLLocationCoordinate2DMake(44.48, 20.27);
    }
    
    return self;
}

#pragma mark - Public API

- (UIImage *)mapImage {
    return [UIImage imageNamed:@"news.png"];
}

@end