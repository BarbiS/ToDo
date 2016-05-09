//
//  Item.h
//  Inheritance
//
//  Created by Djuro Alfirevic on 4/29/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface Item : NSObject <MKAnnotation>
@property (strong, nonatomic) NSString *itemTitle;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *imageURL;
@property (nonatomic) CLLocationCoordinate2D coordinates;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (UIImage *)mapImage;
@end