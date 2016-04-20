//
//  Message.m
//  Viber
//
//  Created by Djuro Alfirevic on 4/19/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Message.h"

@implementation Message

#pragma mark - Designated Initializer

- (instancetype)initWithText:(NSString *)text andSenderType:(SenderType)type {
    if (self = [super init]) {
        self.text = text;
        self.date = [NSDate date];
        self.senderType = type;
    }
    
    return self;
}

@end