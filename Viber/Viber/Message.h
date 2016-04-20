//
//  Message.h
//  Viber
//
//  Created by Djuro Alfirevic on 4/19/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SenderType) {
    ME_SENDER,
    HIM_SENDER
};

@interface Message : NSObject
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) SenderType senderType;

- (instancetype)initWithText:(NSString *)text andSenderType:(SenderType)type;
@end