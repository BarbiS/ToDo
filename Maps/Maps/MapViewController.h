//
//  MapViewController.h
//  Maps
//
//  Created by Djuro Alfirevic on 4/27/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Location.h"

@interface MapViewController : UIViewController
@property (strong, nonatomic) Location *location;
@end