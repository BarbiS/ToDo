//
//  Player.m
//  Dictionary
//
//  Created by Djuro Alfirevic on 7/20/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Player.h"

@implementation Player

#pragma mark - Designated Initializer

- (instancetype)initWithFirstName:(NSString *)fName andLastName:(NSString *)lName {
    if (self = [super init]) {
        self.fName = fName;
        self.lName = lName;
    }
    return self;
}

@end