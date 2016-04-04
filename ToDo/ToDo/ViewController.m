//
//  ViewController.m
//  ToDo
//
//  Created by Djuro Alfirevic on 3/28/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "ViewController.h"

@interface ViewController() <UITextFieldDelegate>
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UIImageView *usernameImageView;
@property (strong, nonatomic) UIImageView *passwordImageView;
@property (strong, nonatomic) UITextField *usernameTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UIButton *forgotPasswordButton;
@property (strong, nonatomic) UIButton *signInButton;
@property (strong, nonatomic) UIButton *signUpButton;
@property (strong, nonatomic) UILabel *dontHaveAccountLabel;
@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Properties
    UIFont *font = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0];
    NSDictionary *attribues = @{
                                NSForegroundColorAttributeName: [UIColor whiteColor],
                                NSFontAttributeName: font
                                };
    
    // 1 - Background image
    self.backgroundImageView = [[UIImageView alloc] init];
    self.backgroundImageView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    self.backgroundImageView.image = [UIImage imageNamed:@"login-bg"];
    [self.view addSubview:self.backgroundImageView];
    
    // 2 - Username
    self.usernameImageView = [[UIImageView alloc] init];
    self.usernameImageView.frame = CGRectMake(30.0, 379.0, 19.0, 19.0);
    self.usernameImageView.image = [UIImage imageNamed:@"username"];
    [self.view addSubview:self.usernameImageView];
    
    // 3 - Password
    self.passwordImageView = [[UIImageView alloc] init];
    self.passwordImageView.frame = CGRectMake(30.0, 424.0, 19.0, 19.0);
    self.passwordImageView.image = [UIImage imageNamed:@"password"];
    [self.view addSubview:self.passwordImageView];
    
    // 4 - Username text field
    CGRect rect = CGRectMake(69.0, 374.0, 286.0, 30.0);
    
    self.usernameTextField = [[UITextField alloc] init];
    self.usernameTextField.frame = rect;
    self.usernameTextField.borderStyle = UITextBorderStyleNone;
    self.usernameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.usernameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.usernameTextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.usernameTextField.textColor = [UIColor whiteColor];
    self.usernameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:attribues];
    self.usernameTextField.delegate = self;
    [self.view addSubview:self.usernameTextField];
    
    // 5 - Password text field
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.frame = CGRectMake(rect.origin.x, 419.0, rect.size.width, rect.size.height);
    self.passwordTextField.borderStyle = self.usernameTextField.borderStyle;
    self.passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:attribues];
    self.passwordTextField.textColor = [UIColor whiteColor];
    self.passwordTextField.delegate = self;
    [self.view addSubview:self.passwordTextField];
    
    // 6 - Separator (initWithFrame !!!)
    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 408.0, self.view.frame.size.width, 1.0)];
    separatorView.backgroundColor = [UIColor lightGrayColor];
    separatorView.alpha = 0.6;
    [self.view addSubview:separatorView];
    
    // 7 - Forgot password?
    self.forgotPasswordButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-118.0-10.0, 464.0, 118.0, 30.0)];
    [self.forgotPasswordButton setTitle:@"Forgot password?" forState:UIControlStateNormal];
    [self.forgotPasswordButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.forgotPasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.forgotPasswordButton.titleLabel.font = font;
    [self.forgotPasswordButton addTarget:self action:@selector(forgotPasswordButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgotPasswordButton];
    
    // 8 - Sign in?
    self.signInButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height-112.0, self.view.frame.size.width, 60.0)];
    [self.signInButton setTitle:@"Sign in" forState:UIControlStateNormal];
    [self.signInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.signInButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    self.signInButton.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:0.0/255.0 blue:65.0/255.0 alpha:1.0];
    self.signInButton.titleLabel.font = font;
    [self.signInButton addTarget:self action:@selector(signInButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.signInButton];
    
    // 9 - Don't have an account
    self.dontHaveAccountLabel = [[UILabel alloc] initWithFrame:CGRectMake(83.0, self.view.frame.size.height-38.0, 150.0, 20.0)];
    self.dontHaveAccountLabel.textColor = [UIColor lightGrayColor];
    self.dontHaveAccountLabel.text = @"Don't have an account?";
    self.dontHaveAccountLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0];
    [self.view addSubview:self.dontHaveAccountLabel];
    
    // 10 - Sign Up
    self.signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(237.0, self.view.frame.size.height-44.0, 51.0, 32.0)];
    [self.signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [self.signUpButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.signUpButton.titleLabel.font = font;
    [self.signUpButton addTarget:self action:@selector(signUpButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.signUpButton];
    
    
    // 5 - weak vs. strong
}

#pragma mark - Actions

- (void)forgotPasswordButtonTapped {
    NSLog(@"forgotPasswordButtonTapped");
    
    
}

- (void)signInButtonTapped {
    NSLog(@"signInButtonTapped");
}

- (void)signUpButtonTapped {
    NSLog(@"signUpButtonTapped");
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
   
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

@end