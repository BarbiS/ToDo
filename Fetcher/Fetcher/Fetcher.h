//
//  Fetcher.h
//  Fetcher
//
//  Created by Djuro Alfirevic on 6/1/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const DATA_DOWNLOADED = @"DATA_DOWNLOADED";

@protocol FetcherDelegate <NSObject>
@optional
- (void)dataFetched:(NSDictionary *)dictionary;
@end

typedef void (^CompletionHandler)(BOOL success, NSDictionary *dictionary, NSError *error);

@interface Fetcher : NSObject
@property (weak, nonatomic) id<FetcherDelegate> delegate;

+ (instancetype)sharedInstance;
- (void)fetchDataFromURL:(NSString *)url withCompletion:(CompletionHandler)handler;
- (void)fetchDataFromURL:(NSString *)url;
@end