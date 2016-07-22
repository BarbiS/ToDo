//
//  MadokaTextFieldView.h
//  AnimatedTextField
//
//  Created by Djuro Alfirevic on 7/22/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface MadokaTextFieldView : UIView
@property (strong, nonatomic) IBInspectable UIColor *color;
@property (strong, nonatomic) IBInspectable UIColor *maskColor;
@property (nonatomic) IBInspectable CGFloat openDuration;
@property (nonatomic) IBInspectable CGFloat closeDuration;
@end