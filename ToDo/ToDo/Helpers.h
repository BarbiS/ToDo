//
//  Helpers.h
//  ToDo
//
//  Created by Cubes School 3 on 5/23/16.
//  Copyright © 2016 Cubes School 3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helpers : NSObject
+ (BOOL)isMorning;
+ (BOOL)isEmailValid:(NSString *)email;
+ (BOOL)isLoggedIn;
+ (UIColor *)colorForTaskGroup:(TaskGroup)group;


@end