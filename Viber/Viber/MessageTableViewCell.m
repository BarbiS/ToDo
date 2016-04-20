//
//  MessageTableViewCell.m
//  Viber
//
//  Created by Djuro Alfirevic on 4/19/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

#pragma mark - Properties

- (void)setMessage:(Message *)message {
    _message = message;
    
    self.messageLabel.text = message.text;
    self.timeLabel.text = [self getTime];
    
    self.messageView.clipsToBounds = YES;
    self.messageView.layer.cornerRadius = 5.0f;
    
    // Rect
    CGRect rect = [[[UIApplication sharedApplication] keyWindow] bounds];
    self.messageViewWidthConstraint.constant = rect.size.width/2 - 50.0f;
    
    CGRect textRect = [self rectForText:message.text
                               withSize:CGSizeMake(self.messageViewWidthConstraint.constant, INT_MAX)
                               withFont:[UIFont fontWithName:@"AvenirNext-Regular" size:14.0]];
    
    self.messageViewHeightConstraint.constant = textRect.size.height + 20.0f;
    [self layoutIfNeeded];
}

#pragma mark - Private API

- (NSString *)getTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    
    return [dateFormatter stringFromDate:self.message.date];
}



















- (CGRect)rectForText:(NSString *)text withSize:(CGSize)size withFont:(UIFont *)font {
    CGRect textRect = [text boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    
    return textRect;
}

@end