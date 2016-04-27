//
//  Location.h
//  Maps
//
//  Created by Djuro Alfirevic on 4/27/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface Location : NSObject <MKAnnotation>
@property (strong, nonatomic) NSString *name;
@property (nonatomic) CLLocationCoordinate2D coordinates;

- (instancetype)initWithName:(NSString *)name andCoordinates:(CLLocationCoordinate2D)coordinates;
@end