//
//  Fetcher.m
//  Fetcher
//
//  Created by Djuro Alfirevic on 6/1/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Fetcher.h"

@implementation Fetcher

#pragma mark - Designated Initializer

+ (instancetype)sharedInstance {
    static Fetcher *sharedManager;
    
    @synchronized(self)	{
        if (sharedManager == nil) {
            sharedManager = [[Fetcher alloc] init];
        }
    }
    
    return sharedManager;
}

#pragma mark - Public API

- (void)fetchDataFromURL:(NSString *)url withCompletion:(CompletionHandler)handler {
    dispatch_queue_t downloadQueue = dispatch_queue_create("ArticlesDownloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        NSError *serializationError;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
        
        if (serializationError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(NO, nil, serializationError);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(YES, dictionary, nil);
            });
        }
    });
}

- (void)fetchDataFromURL:(NSString *)url {
    dispatch_queue_t downloadQueue = dispatch_queue_create("ArticlesDownloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        NSError *serializationError;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
        
        if (serializationError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.delegate respondsToSelector:@selector(dataFetched:)]) {
                    [self.delegate dataFetched:nil];
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:DATA_DOWNLOADED object:nil];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.delegate respondsToSelector:@selector(dataFetched:)]) {
                    [self.delegate dataFetched:dictionary];
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:DATA_DOWNLOADED object:dictionary];
            });
        }
    });

}

@end