//
//  Article.m
//  Fetcher
//
//  Created by Djuro Alfirevic on 6/1/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Article.h"

@implementation Article

#pragma mark - Designated Initializer

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.title = dictionary[@"title"];
        self.desc = dictionary[@"description"];
        self.imageURL = dictionary[@"imageUrl"];
        self.link = dictionary[@"url"];
    }
    
    return self;
}

@end