//
//  AnimatedTextFieldView.h
//  AnimatedTextField
//
//  Created by Djuro Alfirevic on 7/22/16
//  Copyright (c) 2015 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface AnimatedTextFieldView : UIView
@property (strong, nonatomic) IBInspectable UIColor *normalColor;
@property (strong, nonatomic) IBInspectable UIColor *activeColor;
@property (strong, nonatomic) IBInspectable UIColor *activeBackgroundColor;
@property (copy, nonatomic) IBInspectable NSString *placeholderString;
- (void)setText:(NSString *)text;
@end