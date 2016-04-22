//
//  WalkViewController.m
//  ToDo
//
//  Created by Cubes School 3 on 4/22/16.
//  Copyright © 2016 Cubes School 3. All rights reserved.
//

#import "WalkViewController.h"
#import "Constants.h"

@implementation WalkViewController

- (IBAction)closeButtonTapped:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:WALKTHROUGH_PRESENTED];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.navigationController popViewControllerAnimated:YES];

}
@end