//
//  Location.m
//  Maps
//
//  Created by Djuro Alfirevic on 4/27/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Location.h"

@implementation Location

#pragma mark - Designated Initializer

- (instancetype)initWithName:(NSString *)name andCoordinates:(CLLocationCoordinate2D)coordinates {
    if (self = [super init]) {
        self.name = name;
        self.coordinates = coordinates;
    }
    
    return self;
}

#pragma mark - MKAnnotation

- (NSString *)title {
    return self.name;
}

- (CLLocationCoordinate2D)coordinate {
    return self.coordinates;
}

@end