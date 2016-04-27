//
//  MapViewController.m
//  Maps
//
//  Created by Djuro Alfirevic on 4/27/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "MapViewController.h"

#define kRegionRadius 5000

@interface MapViewController() <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation MapViewController

#pragma mark - Actions

- (IBAction)cancelButtonTapped {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Private API

- (void)zoomMapToCoordinate:(CLLocationCoordinate2D)coordinate {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, kRegionRadius * 2.0, kRegionRadius * 2.0);
    MKCoordinateRegion coordinateRegion = [self.mapView regionThatFits:region];
    [self.mapView setRegion:coordinateRegion animated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.location) {
            [self.mapView addAnnotation:self.location];
        }
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self zoomMapToCoordinate:self.location.coordinates];
    });
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    if (pinView == nil) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
    }
    
    pinView.canShowCallout = YES;
    pinView.animatesDrop = YES;
    pinView.pinTintColor = [UIColor colorWithRed:0.18 green:0.54 blue:0.49 alpha:1.0];
    
    // UIButton
    UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    button.frame = CGRectMake(0, 0, 40, 40);
    pinView.rightCalloutAccessoryView = button;
    
    return pinView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"Tapped");
}

@end