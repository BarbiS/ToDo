//
//  Designer.m
//  TableView
//
//  Created by Djuro Alfirevic on 4/18/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Designer.h"

@implementation Designer

#pragma mark - Designated Initializer

- (instancetype)initWithName:(NSString *)name imageURL:(NSString *)imageURL andGender:(Gender)gender {
    if (self = [super init]) {
        self.name = name;
        self.imageURL = imageURL;
        self.gender = gender;
    }
    
    return self;
}

@end