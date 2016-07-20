//
//  Animator.h
//  CustomTransition
//
//  Created by Djuro Alfirevic on 7/20/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimationDirection) {
    UP_ANIMATION_DIRECTION = 1,
    DOWN_ANIMATION_DIRECTION = 2,
    LEFT_ANIMATION_DIRECTION = 3,
    RIGHT_ANIMATION_DIRECTION = 4
};

typedef NS_ENUM(NSInteger, TransitionMode) {
    PRESENT_TRANSITION_MODE,
    DISMISS_TRANSITION_MODE
};

@interface Animator : NSObject <UIViewControllerAnimatedTransitioning>
// Push
@property (nonatomic) BOOL isPop;
@property (nonatomic) BOOL isModal;
@property (nonatomic) AnimationDirection direction;

// Modal
@property (nonatomic) TransitionMode transitionMode;
@property (strong, nonatomic) UIColor *squareColor;
@property (nonatomic) CGRect squareRect;
@property (nonatomic) CGPoint origin;
@end