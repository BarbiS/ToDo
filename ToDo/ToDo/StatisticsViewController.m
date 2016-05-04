//
//  StatisticsViewController.m
//  ToDo
//
//  Created by Cubes School 3 on 5/4/16.
//  Copyright © 2016 Cubes School 3. All rights reserved.
//

#import "StatisticsViewController.h"

@interface StatisticsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *completedPercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *notCompletedPercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *inProgressPercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *completedCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *notCompletedCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *inProgressCountLabel;

@end

@implementation StatisticsViewController

#pragma mark - Actions

-(IBAction)backButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - View lifestyle

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)viewDidLoad{
    [super viewDidLoad];
}

@end