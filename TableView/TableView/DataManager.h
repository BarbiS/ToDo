//
//  DataManager.h
//  TableView
//
//  Created by Djuro Alfirevic on 4/18/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
@property (strong, nonatomic) NSMutableArray *itemsArray;

+ (DataManager *)sharedInstance;
- (NSArray *)femaleDesigners;
- (NSArray *)maleDesigners;
@end