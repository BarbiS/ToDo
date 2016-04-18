//
//  Designer.h
//  TableView
//
//  Created by Djuro Alfirevic on 4/18/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface Designer : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imageURL;
@property (nonatomic) Gender gender;

- (instancetype)initWithName:(NSString *)name imageURL:(NSString *)imageURL andGender:(Gender)gender;
@end