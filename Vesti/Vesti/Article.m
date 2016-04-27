//
//  Article.m
//  Vesti
//
//  Created by Djuro Alfirevic on 4/26/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Article.h"

@implementation Article

#pragma mark - Designated Initializer

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)desc imageURL:(NSString *)imageURL andLink:(NSString *)link {
    if (self = [super init]) {
        self.title = title;
        self.desc = desc;
        self.imageURL = imageURL;
        self.link = link;
    }
    
    return self;
}

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