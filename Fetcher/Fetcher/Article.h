//
//  Article.h
//  Fetcher
//
//  Created by Djuro Alfirevic on 6/1/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *link;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end