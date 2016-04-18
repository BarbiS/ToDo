//
//  MenuView.m
//  Playground
//
//  Created by Djuro Alfirevic on 4/13/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "MenuView.h"

#define kButtonSize 50.0
#define kGap        20.0

@interface MenuView()
@property (strong, nonatomic) UIButton *mainButton;
@property (strong, nonatomic) UIButton *button1;
@property (strong, nonatomic) UIButton *button2;
@property (strong, nonatomic) UIButton *button3;
@property (strong, nonatomic) UIButton *button4;
@property (strong, nonatomic) UIButton *button5;
@property (nonatomic) BOOL isOpened;
@end

@implementation MenuView

#pragma mark - Designated Initializer

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureMenu];
    }
    
    return self;
}

#pragma mark - Actions

- (void)mainButtonTapped {
    if (self.isOpened) {
        [self closeMenu];
    } else {
        [self openMenu];
    }
}

- (void)optionButtonTapped:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            NSLog(@"Prvo dugme klinknuto");
            break;
        case 3:
            NSLog(@"Trece dugme klinknuto");
            break;
        case 5:
            NSLog(@"Peto dugme klinknuto");
            break;
        default:
            break;
    }
}

- (void)openMenu {
    self.isOpened = YES;
    
    // Rotate main button
    [UIView animateWithDuration:0.2 animations:^{
        self.mainButton.transform = CGAffineTransformMakeRotation(M_PI_4);
    }];
    
    // Animate buttons
    [UIView animateWithDuration:0.4
                          delay:0.0
         usingSpringWithDamping:4.0
          initialSpringVelocity:10.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.button1.frame = CGRectMake(self.mainButton.frame.origin.x - kButtonSize - kGap, self.mainButton.frame.origin.y, kButtonSize, kButtonSize);
                     } completion:^(BOOL finished) {}];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.4
                              delay:0.0
             usingSpringWithDamping:4.0
              initialSpringVelocity:10.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.button3.frame = CGRectMake(self.mainButton.frame.origin.x, self.mainButton.frame.origin.y - kButtonSize - kGap, kButtonSize, kButtonSize);
                         } completion:^(BOOL finished) {}];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.4
                              delay:0.0
             usingSpringWithDamping:4.0
              initialSpringVelocity:10.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.button5.frame = CGRectMake(self.mainButton.frame.origin.x + kButtonSize + kGap, self.mainButton.frame.origin.y, kButtonSize, kButtonSize);
                         } completion:^(BOOL finished) {}];
    });
}

- (void)closeMenu {
    self.isOpened = NO;
    
    // Rotate main button
    [UIView animateWithDuration:0.2 animations:^{
        self.mainButton.transform = CGAffineTransformIdentity;
    }];
    
    // Animate buttons
    [UIView animateWithDuration:0.4
                          delay:0.0
         usingSpringWithDamping:4.0
          initialSpringVelocity:10.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.button1.frame = self.mainButton.frame;
                         self.button3.frame = self.mainButton.frame;
                         self.button5.frame = self.mainButton.frame;
                     } completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark - Private API

- (void)configureMenu {
    self.backgroundColor = [UIColor yellowColor];
    
    // Main button
    self.mainButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width-kButtonSize)/2, self.frame.size.height-kButtonSize-5, kButtonSize, kButtonSize)];
    self.mainButton.backgroundColor = [UIColor colorWithRed:155.0/255.0 green:22.0/255.0 blue:212.0/255.0 alpha:1.0];
    self.mainButton.layer.cornerRadius = kButtonSize/2;
    [self.mainButton addTarget:self action:@selector(mainButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.mainButton setTitle:@"+" forState:UIControlStateNormal];
    self.mainButton.titleLabel.font = [UIFont systemFontOfSize:40.0];
    [self addSubview:self.mainButton];
    
    // Button 1
    self.button1 = [[UIButton alloc] initWithFrame:self.mainButton.frame];
    self.button1.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:200.0/255.0 alpha:1.0];
    self.button1.layer.cornerRadius = kButtonSize/2;
    [self.button1 addTarget:self action:@selector(optionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.button1.tag = 1;
    [self addSubview:self.button1];
    
    // Button 3
    self.button3 = [[UIButton alloc] initWithFrame:self.mainButton.frame];
    self.button3.backgroundColor = [UIColor colorWithRed:80.0/255.0 green:40.0/255.0 blue:190.0/255.0 alpha:1.0];
    self.button3.layer.cornerRadius = kButtonSize/2;
    [self.button3 addTarget:self action:@selector(optionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.button3.tag = 3;
    [self addSubview:self.button3];
    
    // Button 5
    self.button5 = [[UIButton alloc] initWithFrame:self.mainButton.frame];
    self.button5.backgroundColor = [UIColor colorWithRed:60.0/255.0 green:33.0/255.0 blue:240.0/255.0 alpha:1.0];
    self.button5.layer.cornerRadius = kButtonSize/2;
    [self.button5 addTarget:self action:@selector(optionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.button5.tag = 5;
    [self addSubview:self.button5];
    
    [self bringSubviewToFront:self.mainButton];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

@end