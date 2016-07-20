//
//  Animator.m
//  CustomTransition
//
//  Created by Djuro Alfirevic on 7/20/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Animator.h"

@interface Animator()
@property (strong, nonatomic) UIView *squareView;
@end

@implementation Animator

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (self.isModal) {
        if (self.transitionMode == PRESENT_TRANSITION_MODE) {
            // Get view of view controller being presented
            UIView *presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];
            CGPoint originalCenter = presentedView.center;
            
            // Get frame of circle
            self.squareView = [[UIView alloc] initWithFrame:self.squareRect];
            self.squareView.center = self.origin;
            
            // Make it very small
            self.squareView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            
            // Set the background color
            self.squareView.backgroundColor = self.squareColor;
            
            // Add square to container view
            [[transitionContext containerView] addSubview:self.squareView];
            
            // Make presented view very small and transparent
            presentedView.center = self.origin;
            presentedView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            
            // Set the background color
            presentedView.backgroundColor = self.squareColor;
            
            // Add presented view to container view
            [[transitionContext containerView] addSubview:presentedView];
            
            // Animate both views
            [UIView animateWithDuration:0.3f animations:^{
                self.squareView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                presentedView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                presentedView.center = originalCenter;
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        } else {
            // Essentially doing the same thing, but in reverse
            UIView *returningControllerView = [transitionContext viewForKey:UITransitionContextFromViewKey];
            self.squareView.frame = self.squareRect;
            self.squareView.center = self.origin;
            
            [UIView animateWithDuration:0.3f animations:^{
                self.squareView.transform = CGAffineTransformMakeScale(0.001, 0.001);
                returningControllerView.transform = CGAffineTransformMakeScale(0.001, 0.001);
                returningControllerView.center = self.origin;
                //returningControllerView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [returningControllerView removeFromSuperview];
                [self.squareView removeFromSuperview];
                [transitionContext completeTransition:YES];
            }];
        }
    } else {
        if (self.isPop) { // Pop
            [[transitionContext containerView] insertSubview:toViewController.view belowSubview:fromViewController.view];
            
            CGFloat x = 0.0;
            CGFloat y = 0.0;
            CGFloat width = screenRect.size.width;
            CGFloat height = screenRect.size.height;
            
            switch (self.direction) {
                case UP_ANIMATION_DIRECTION: {
                    y = -height;
                }
                    break;
                case DOWN_ANIMATION_DIRECTION: {
                    y = height;
                }
                    break;
                case LEFT_ANIMATION_DIRECTION: {
                    x = -width;
                }
                    break;
                case RIGHT_ANIMATION_DIRECTION: {
                    x = width;
                }
                    break;
            }
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                fromViewController.view.frame = CGRectMake(x, y, width, height);
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        } else  {// Push
            CGFloat x = 0.0;
            CGFloat y = 0.0;
            CGFloat width = screenRect.size.width;
            CGFloat height = screenRect.size.height;
            
            switch (self.direction) {
                case UP_ANIMATION_DIRECTION: {
                    y = -height;
                }
                    break;
                case DOWN_ANIMATION_DIRECTION: {
                    y = height;
                }
                    break;
                case LEFT_ANIMATION_DIRECTION: {
                    x = -width;
                }
                    break;
                case RIGHT_ANIMATION_DIRECTION: {
                    x = width;
                }
                    break;
            }
            
            toViewController.view.frame = CGRectMake(x, y, width, height);
            
            [[transitionContext containerView] addSubview:toViewController.view];
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                toViewController.view.frame = screenRect;
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        }
    }
}

@end