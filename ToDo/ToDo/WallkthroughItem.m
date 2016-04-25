//
//  WallkthroughItem.m
//  ToDo
//
//  Created by Cubes School 3 on 4/25/16.
//  Copyright © 2016 Cubes School 3. All rights reserved.
//

#import "WallkthroughItem.h"

@implementation WallkthroughItem

- (instancetype)initWithText:(NSString *)text andImage:(UIImage *)image {
    if (self  = [super init]) {
        self.text =  text;
        self.image = image;
    }
    
    return self;
}

@end