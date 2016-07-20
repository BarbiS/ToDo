//
//  MenuViewController.m
//  CustomTransition
//
//  Created by Djuro Alfirevic on 7/20/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "MenuViewController.h"
#import "ModalViewController.h"
#import "Animator.h"

@interface MenuViewController() <UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>
@property (strong, nonatomic) Animator *animator;
@property (strong, nonatomic) UIColor *buttonColor;
@property (nonatomic) CGPoint originPoint;
@property (nonatomic) CGRect rect;
@end

@implementation MenuViewController

#pragma mark - Properties

- (Animator *)animator {
    if (!_animator) {
        _animator = [[Animator alloc] init];
    }
    
    return _animator;
}

#pragma mark - Actions

- (IBAction)modalButtonTapped:(UIButton *)sender {
    self.buttonColor = sender.backgroundColor;
    self.rect = sender.frame;
    self.originPoint = sender.center;
    
    [self performSegueWithIdentifier:@"Modal Segue" sender:self];
}

- (IBAction)menuButtonTapped:(UIButton *)sender {
    self.animator.direction = sender.tag;
    
    [self performSegueWithIdentifier:@"Push Segue" sender:self];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    self.originPoint = CGPointMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Modal Segue"]) {
        ModalViewController *toViewController = segue.destinationViewController;
        toViewController.transitioningDelegate = self;
        toViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC {
    self.animator.isModal = NO;
    self.animator.isPop = (operation == UINavigationControllerOperationPop);
    
    return self.animator;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    self.animator.isModal = YES;
    self.animator.transitionMode = PRESENT_TRANSITION_MODE;
    self.animator.squareColor = self.buttonColor;
    self.animator.squareRect = self.rect;
    self.animator.origin = self.originPoint;
    
    return self.animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.animator.isModal = YES;
    self.animator.transitionMode = DISMISS_TRANSITION_MODE;
    self.animator.squareColor = self.buttonColor;
    self.animator.squareRect = self.rect;
    self.animator.origin = self.originPoint;
    
    return self.animator;
}

@end