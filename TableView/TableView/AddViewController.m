//
//  AddViewController.m
//  TableView
//
//  Created by Djuro Alfirevic on 4/18/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "AddViewController.h"
#import "Constants.h"
#import "DataManager.h"

@interface AddViewController()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *imageURLTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegmentedControl;
@property (strong, nonatomic) DataManager *dataManager;
@end

@implementation AddViewController

#pragma mark - Actions

- (IBAction)saveButtonTapped {
    if (self.designer == nil) {
        Designer *designer = [[Designer alloc] initWithName:self.nameTextField.text
                                                   imageURL:self.imageURLTextField.text
                                                  andGender:self.genderSegmentedControl.selectedSegmentIndex];
        
        [self.dataManager.itemsArray addObject:designer];
    } else {
        self.designer.name = self.nameTextField.text;
        self.designer.imageURL = self.imageURLTextField.text;
        self.designer.gender = self.genderSegmentedControl.selectedSegmentIndex;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataManager = [DataManager sharedInstance];
    
    if (self.designer) {
        self.nameTextField.text = self.designer.name;
        self.imageURLTextField.text = self.designer.imageURL;
        self.genderSegmentedControl.selectedSegmentIndex = self.designer.gender;
    }
}

@end