//
//  MapViewController.h
//  Inheritance
//
//  Created by Djuro Alfirevic on 4/29/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Item.h"

@interface MapViewController : UIViewController
@property (strong, nonatomic) Item *item;
@end