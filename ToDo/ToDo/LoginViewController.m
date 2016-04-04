//
//  LoginViewController.m
//  ToDo
//
//  Created by Djuro Alfirevic on 3/30/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "LoginViewController.h"

#define kConstant 50.0

@interface LoginViewController() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *usernameImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *logoView;
@end

@implementation LoginViewController

#pragma mark - Private API

- (void)configureTextField:(UITextField *)textField {
    if (textField.placeholder.length > 0) {
//        UIColor *color = [UIColor colorWithRed:117.0/255.0
//                                         green:113.0/255.0
//                                          blue:111.0/255.0
//                                         alpha:1.0];
        
        NSDictionary *attributes = @{
                                     NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Regular" size:14.0],
                                     NSForegroundColorAttributeName: [UIColor whiteColor]
                                     };
        
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textField.placeholder
                                                                          attributes:attributes];
    }
}

#pragma mark - Actions

- (IBAction)forgotPasswordButtonTapped:(UIButton *)sender {
}

- (IBAction)signInButtonTapped:(UIButton *)sender {
}

- (IBAction)signUpButtonTapped:(UIButton *)sender {
    NSLog(@"Sign up...");
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTextField:self.usernameTextField];
    [self configureTextField:self.passwordTextField];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:3.0 animations:^{
        self.logoView.alpha = 0.0;
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:10.0
                          delay:0.0
         usingSpringWithDamping:0.4
          initialSpringVelocity:10.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.containerView.frame;
                         frame.origin.y = frame.origin.y - kConstant;
                         self.containerView.frame = frame;
                     }
                     completion:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:1.0
                          delay:0.0
         usingSpringWithDamping:0.4
          initialSpringVelocity:10.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.containerView.frame;
                         frame.origin.y = frame.origin.y + kConstant;
                         self.containerView.frame = frame;
                     }
                     completion:nil];
}

@end