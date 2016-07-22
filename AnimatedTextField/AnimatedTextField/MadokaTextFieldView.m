//
//  MadokaTextFieldView.m
//  AnimatedTextField
//
//  Created by Djuro Alfirevic on 7/22/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "MadokaTextFieldView.h"

@interface MadokaTextFieldView() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *topBorderView;
@property (weak, nonatomic) IBOutlet UIView *leftBorderView;
@property (weak, nonatomic) IBOutlet UIView *rightBorderView;
@property (weak, nonatomic) IBOutlet UIView *bottomBorderView;

@property (weak, nonatomic) IBOutlet UIView *leftMaskView;
@property (weak, nonatomic) IBOutlet UIView *rightMaskView;
@property (weak, nonatomic) IBOutlet UIView *topMaskView;

@property (nonatomic) CGRect placeholderLabelOriginalFrame;
@end

@implementation MadokaTextFieldView

#pragma mark - Properties

- (void)setColor:(UIColor *)color {
    _color = color;
    
    [self updateUI];
}

- (void)setMaskColor:(UIColor *)maskColor {
    _maskColor = maskColor;
    
    [self updateUI];
}

#pragma mark - Designated Initializers

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self updateUI];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self updateUI];
    }
    
    return self;
}

#pragma mark - Private API

- (void)open {
    [UIView animateKeyframesWithDuration:3 * self.openDuration delay:0.0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:self.openDuration animations:^{
            self.placeholderLabel.layer.affineTransform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
            
            CGRect frame = self.placeholderLabel.frame;
            frame.origin.x = self.placeholderLabelOriginalFrame.origin.x;
            frame.origin.y = self.bottomBorderView.frame.origin.y + 5.0f;
            self.placeholderLabel.frame = frame;
            
            // Right view
            CGRect rightViewFrame = self.rightMaskView.frame;
            rightViewFrame.size.height = 0;
            self.rightMaskView.frame = rightViewFrame;
        }];
        [UIView addKeyframeWithRelativeStartTime:self.openDuration relativeDuration:self.closeDuration animations:^{
            // Top view
            CGRect topViewFrame = self.topMaskView.frame;
            topViewFrame.size.width = 0;
            self.topMaskView.frame = topViewFrame;
        }];
        [UIView addKeyframeWithRelativeStartTime:2 * self.openDuration relativeDuration:self.closeDuration animations:^{
            // Left view
            CGRect leftViewFrame = self.leftMaskView.frame;
            leftViewFrame.origin.y = self.bottomBorderView.frame.origin.y;
            leftViewFrame.size.height = 0;
            self.leftMaskView.frame = leftViewFrame;
        }];
    } completion:NULL];
}

- (void)close {
    [UIView animateKeyframesWithDuration:3 * self.closeDuration delay:0.0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:self.closeDuration animations:^{
            self.placeholderLabel.layer.affineTransform = CGAffineTransformIdentity;
            self.placeholderLabel.frame = self.placeholderLabelOriginalFrame;
            
            // Left view
            CGRect leftViewFrame = self.leftMaskView.frame;
            leftViewFrame.size.height = -self.bottomBorderView.frame.origin.y;
            leftViewFrame.origin.y = self.bottomBorderView.frame.origin.y;
            self.leftMaskView.frame = leftViewFrame;
        }];
        [UIView addKeyframeWithRelativeStartTime:self.closeDuration relativeDuration:self.closeDuration animations:^{
            // Top view
            CGRect topViewFrame = self.topMaskView.frame;
            topViewFrame.size.width = self.bounds.size.width;
            self.topMaskView.frame = topViewFrame;
        }];
        [UIView addKeyframeWithRelativeStartTime:2 * self.closeDuration relativeDuration:self.closeDuration animations:^{
            // Right view
            CGRect rightViewFrame = self.rightMaskView.frame;
            rightViewFrame.size.height = self.bottomBorderView.frame.origin.y;
            self.rightMaskView.frame = rightViewFrame;
        }];
    } completion:NULL];
}

- (void)updateUI {
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class])
                                                                   owner:self
                                                                 options:nil] firstObject];
    [self addSubview:view];
    view.frame = self.bounds;
    
    self.topBorderView.backgroundColor = self.color;
    self.leftBorderView.backgroundColor = self.color;
    self.rightBorderView.backgroundColor = self.color;
    self.bottomBorderView.backgroundColor = self.color;
    self.placeholderLabel.textColor = self.color;
    
    self.leftMaskView.backgroundColor = self.maskColor;
    self.rightMaskView.backgroundColor = self.maskColor;
    self.topMaskView.backgroundColor = self.maskColor;
    
    self.placeholderLabelOriginalFrame = self.placeholderLabel.frame;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if (textField.text.length == 0) {
        [self close];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self open];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self close];
}

@end