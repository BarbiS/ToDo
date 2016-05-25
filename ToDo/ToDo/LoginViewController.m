//
//  LoginViewController.m
//  ToDo
//
//  Created by Djuro Alfirevic on 3/30/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "LoginViewController.h"
#import "Constants.h"
#import "UIViewController+Utilities.h"

#define kConstant 50.0
#define ZERO_VALUE 0.0

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
    NSLog(@"Forgot password...");
}

- (IBAction)signInButtonTapped:(UIButton *)sender{
    
    [self.activityIndicatorView startAnimating];
    
    sender.enabled=NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"HomeSegue" sender:self];
    });
    
}

- (IBAction)signUpButtonTapped:(UIButton *)sender {
    NSLog(@"Sign up...");
}

- (IBAction)sumbitButtonTapped {
   
    
    if (self.usernameTextField.text.length == 0) {
        [self presentErrorWithTitle:@"Validation" andError:@"Please enter your username"];
        return;
    }
    
    if (self.passwordTextField.text.length == 0) {
        [self presentErrorWithTitle:@"Validation" andError:@"Please enter your password"];
        return;
    }
    
    NSLog(@"Signing in...");
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:LOGED_IN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.activityIndicatorView startAnimating];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.activityIndicatorView stopAnimating];
        [self performSegueWithIdentifier:@"HomeSegue" sender:nil];
        
    });
    }

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTextFieldPlaceholders];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self prepareForAnimations];
    [self.activityIndicatorView stopAnimating];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self animate];
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

- (void)prepareForAnimations{
    // Footer View
    CGRect footerViewFrame = self.footerView.frame;
    footerViewFrame.origin.y = self.view.frame.size.height;
    self.footerView.frame = footerViewFrame;
    
    // Sign in Button
    CGRect submitButtonFrame = self.submitButton.frame;
    submitButtonFrame.origin.x = self.submitButton.frame.size.width;
    self.submitButton.frame = submitButtonFrame;
    
    
    // Mask Logo view
    self.maskLogoView.layer.cornerRadius = self.maskLogoView.frame.size.width/2;
}

- (void)animate {
    [UIView animateWithDuration:0.4 animations:^{
        CGRect frame = self.footerView.frame;
        frame.origin.y = 625;
        self.footerView.frame = frame;
    }];
    
    [UIView animateWithDuration:0.4
                          delay:0.2
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect submitButtonFrame = self.submitButton.frame;
                         submitButtonFrame.origin.x = ZERO_VALUE;
                         self.submitButton.frame = submitButtonFrame;
                     }
                     completion:NULL];
    
    [UIView animateWithDuration:0.4
                          delay:0.2
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.maskLogoView.alpha = ZERO_VALUE;
                     }
                     completion:NULL];
}

#pragma mark - Public API

- (void)configureTextFieldPlaceholders {
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc]init];
    [attributes setObject:[UIFont fontWithName:@"Avenir-Book" size:15.0] forKey:NSFontAttributeName];
    [attributes setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    NSAttributedString *usernamePlaceholder = [[NSAttributedString alloc] initWithString:self.usernameTextField.placeholder attributes:attributes];
    self.usernameTextField.attributedPlaceholder = usernamePlaceholder;
    
    NSAttributedString *passwordPlaceholder = [[NSAttributedString alloc] initWithString:self.passwordTextField.placeholder attributes:attributes];
    self.passwordTextField.attributedPlaceholder = passwordPlaceholder;
}

@end