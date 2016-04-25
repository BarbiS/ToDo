//
//  WallkthroughItem.h
//  ToDo
//
//  Created by Cubes School 3 on 4/25/16.
//  Copyright © 2016 Cubes School 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WallkthroughItem : NSObject
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) UIImage *image;

- (instancetype)initWithText:(NSString *)text andImage:(UIImage *)image;
@end