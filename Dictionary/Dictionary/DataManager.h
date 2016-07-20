//
//  DataManager.h
//  Dictionary
//
//  Created by Djuro Alfirevic on 7/20/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
+ (instancetype)sharedInstance;
- (void)fillDummyData;
- (NSMutableDictionary *)prepareDictionary;
@end