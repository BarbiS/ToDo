//
//  Player.h
//  Dictionary
//
//  Created by Djuro Alfirevic on 7/20/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
@property (strong, nonatomic) NSString *fName;
@property (strong, nonatomic) NSString *lName;
- (instancetype)initWithFirstName:(NSString *)fName andLastName:(NSString *)lName;
@end