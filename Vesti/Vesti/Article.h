//
//  Article.h
//  Vesti
//
//  Created by Djuro Alfirevic on 4/26/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *link;

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)desc imageURL:(NSString *)imageURL andLink:(NSString *)link;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end