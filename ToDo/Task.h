//
//  Task.h
//  ToDo
//
//  Created by Cubes School 3 on 5/11/16.
//  Copyright © 2016 Cubes School 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSManagedObject <MKAnnotation>
- (BOOL)isLocationValid;
@end

NS_ASSUME_NONNULL_END

#import "Task+CoreDataProperties.h"