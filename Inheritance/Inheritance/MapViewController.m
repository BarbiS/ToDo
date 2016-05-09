//
//  MapViewController.m
//  Inheritance
//
//  Created by Djuro Alfirevic on 4/29/16.
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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.item) {
            [self.mapView addAnnotation:self.item];
        }
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self zoomMapToCoordinate:self.item.coordinates];
    });
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    if (pinView == nil) {
        pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
    }
    
    pinView.canShowCallout = YES;
    
    // UIImage
    pinView.image = [self.item mapImage];
    
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