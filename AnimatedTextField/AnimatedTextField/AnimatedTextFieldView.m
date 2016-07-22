//
//  AnimatedTextFieldView.m
//  AnimatedTextField
//
//  Created by Djuro Alfirevic on 7/22/16.
//  Copyright (c) 2015 Djuro Alfirevic. All rights reserved.
//

#import "AnimatedTextFieldView.h"

@interface AnimatedTextFieldView() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *placeholderLabelVerticalConstraint;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) IBOutlet UIView *activeBackgroundView;
@end

@implementation AnimatedTextFieldView

#pragma mark - Properties

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    
    [self updateUI];
}

- (void)setPlaceholderString:(NSString *)placeholderString {
    _placeholderString = placeholderString;
    
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

#pragma mark - Public API

- (void)setText:(NSString *)text {
    self.placeholderLabelVerticalConstraint.constant = 30.0f;
    self.placeholderLabel.alpha = 1.0f;
    [self layoutIfNeeded];
    self.textField.text = text;
}

#pragma mark - Private API

- (void)open {
    self.placeholderLabelVerticalConstraint.constant = 30.0f;
    [UIView animateWithDuration:0.5f animations:^{
        self.placeholderLabel.alpha = 1.0f;
        [self layoutIfNeeded];
    }];
    
}

- (void)close {
    [UIView animateWithDuration:0.5f animations:^{
        self.placeholderLabel.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.placeholderLabelVerticalConstraint.constant = 10.0f;
    }];
}

- (void)updateUI {
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class])
                                                                  owner:self
                                                                options:nil] firstObject];
    [self addSubview:view];
    view.frame = self.bounds;
    
    self.separatorView.backgroundColor = self.normalColor;
    self.placeholderLabel.text = self.placeholderString;
    self.placeholderLabel.alpha = 0.0f;
    self.textField.placeholder = self.placeholderString;
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
    self.placeholderLabel.text = textField.placeholder;
    self.separatorView.backgroundColor = self.activeColor;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.activeBackgroundView.backgroundColor = self.activeBackgroundColor;
    }];
    
    [self open];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.separatorView.backgroundColor = self.normalColor;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.activeBackgroundView.backgroundColor = [UIColor clearColor];
    }];
}

@end