//
//  WebViewController.m
//  ToDo
//
//  Created by Cubes School 3 on 5/4/16.
//  Copyright © 2016 Cubes School 3. All rights reserved.
//

#import "WebViewController.h"
#import "Constants.h"

@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@end

@implementation WebViewController

#pragma mark - Actions

- (IBAction)closeButtonTapped {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Private API

-(void)animateCloseButton{
   
    
    
    
    
}

#pragma mark - View lyfecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self animateCloseButton];
    self.closeButton.alpha = ZERO_VALUE;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
     [self animateCloseButton];
}
@end
