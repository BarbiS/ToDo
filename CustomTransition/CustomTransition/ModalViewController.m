//
//  ModalViewController.m
//  CustomTransition
//
//  Created by Djuro Alfirevic on 7/20/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "ModalViewController.h"

@implementation ModalViewController

#pragma mark - Actions

- (IBAction)closeButtonTapped {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end