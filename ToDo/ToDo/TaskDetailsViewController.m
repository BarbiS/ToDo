//
//  TaskDetailsViewController.m
//  ToDo
//
//  Created by Cubes School 3 on 5/20/16.
//  Copyright © 2016 Cubes School 3. All rights reserved.
//

#import "TaskDetailsViewController.h"
#import "DataManager.h"
#import <MapKit/MapKit.h>


#define kRegionRadius  50000

@interface TaskDetailsViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *groupSelectorImageView;
@property (weak, nonatomic) IBOutlet UIView *completedView;
@property (weak, nonatomic) IBOutlet UIView *notCompletedView;
@property (weak, nonatomic) IBOutlet UIView *inProgressView;
@property (nonatomic) NSInteger group;

@end

@implementation TaskDetailsViewController

#pragma mark - Properties

-(void)setGroup:(NSInteger)group {
    _group = group;
    
    __block CGPoint point;
    
    switch (group) {
        case COMPLETED_TASK_GROUP:
            point = self.completedView.center;
            break;
            
        case NOT_COMPLETED_TASK_GROUP:
            point = self.notCompletedView.center;
            break;
            
        case IN_PROGRESS_TASK_GROUP:
            point = self.inProgressView.center;
            break;
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        self.groupSelectorImageView.center = point;
    }];
}


#pragma mark - Actions

- (IBAction)backButtonTapped {
    if ([self isEdited] &&  !self.task) {
        [self configureAlert];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)addButtonTapped:(id)sender {
}

- (IBAction)groupButtonTapped:(UIButton *)sender {
    self.group = sender.tag;
}

- (IBAction)mapButtonTapped:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.mapView.alpha = (sender.selected) ? 1.0 : ZERO_VALUE;
    }];
}

#pragma mark - Private API

- (void)configureTextFieldPlaceholders{
    NSMutableDictionary *titleAttributes = [[NSMutableDictionary alloc]init];
    [titleAttributes setObject:[UIFont fontWithName:@"Avenir-Light" size:35.0]
                        forKey:NSFontAttributeName];
    [titleAttributes setObject:[UIColor whiteColor]
                        forKey:NSForegroundColorAttributeName];
    
    NSAttributedString *titlePlaceholder = [[NSAttributedString alloc]initWithString:self.titleTextField.placeholder attributes:titleAttributes];
    self.titleTextField.attributedPlaceholder = titlePlaceholder;
    
    NSMutableDictionary *descriptionAttributes = [[NSMutableDictionary alloc]init];
    [descriptionAttributes setObject:[UIFont fontWithName:@"Avenir-Book" size:14.0]
                        forKey:NSFontAttributeName];
    [descriptionAttributes setObject:kDescPlaceholderColor
                        forKey:NSForegroundColorAttributeName];
    
    NSAttributedString *descriptionPlaceholder = [[NSAttributedString alloc]initWithString:self.descriptionTextField.placeholder attributes:descriptionAttributes];
    self.descriptionTextField.attributedPlaceholder = descriptionPlaceholder;
}

- (void)configureAlert {
    
}

- (BOOL)isEdited {
    return YES;
}

- (void)saveTask{
    if (self.titleTextField.text.length == 0) {
        [self presentErrorWithTitle:@"Validation" andError:@"Please add title."];
        return;
    }
    
    if (self.descriptionTextField.text.length == 0) {
        [self presentErrorWithTitle:@"Validation" andError:@"Please add short description."];
        return;
    }
    
    // If we have task object, we should preform update
    if (self.task) {
        self.task.heading = self.titleTextField.text;
        self.task.desc = self.descriptionTextField.text;
        self.task.group = [NSNumber numberWithInteger:self.group];
        [[DataManager sharedInstance] saveTaskWithTitle:self.titleTextField.text description:self.descriptionTextField.text group:self.group];
    }
    
    self.titleTextField.text  = EMPTY_STRING;
    self.descriptionTextField.text = EMPTY_STRING;
    [self backButtonTapped];
    
}

- (void)viewDidLoad {
    [self configureTextFieldPlaceholders];
}
@end