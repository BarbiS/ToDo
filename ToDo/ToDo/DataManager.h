//
//  DataManager.h
//  ToDo
//
//  Created by Cubes School 3 on 5/11/16.
//  Copyright © 2016 Cubes School 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
#import "Constants.h"

@interface DataManager : NSObject
@property (strong, nonatomic) CLLocation *userLocation;
@property (strong, nonatomic) NSString *userLocality;

+ (instancetype)sharedInstance;
- (NSMutableArray *)fetchEntity:(NSString *)entityName
                     withFilter:(NSString *)filter
                    withSortAsc:(BOOL)sortAscending
                         forKey:(NSString *)sortKey;
- (void)deleteObjectInDatabase:(NSManagedObject *)object;
- (void)updateObject:(NSManagedObject *)object;
- (void)logObject:(NSManagedObject *)object;
- (CGFloat)numberOfTasksPerTaskGroup:(TaskGroup)group;
- (void)saveTaskWithTitle:(NSString *)title
              description:(NSString *)description
                    group:(NSInteger)group;
@end