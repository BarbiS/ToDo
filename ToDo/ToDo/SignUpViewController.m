//
//  SignUpViewController.m
//  ToDo
//
//  Created by Cubes School 3 on 3/30/16.
//  Copyright © 2016 Cubes School 3. All rights reserved.
//

#import "SignUpViewController.h"

@implementation SignUpViewController


#pragma mark - Actions

- (IBAction)SignUpBack:(UIButton *)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    [self.navigationController popViewControllerAnimated:(YES)];
}

@end