//
//  ViewController.m
//  Weather
//
//  Created by Djuro Alfirevic on 7/13/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSString *yahooWoeidURL;
@property (copy, nonatomic) NSString *woeid;
@property (copy, nonatomic) NSString *yahooWeatherURL;
@end

@implementation ViewController

#pragma mark - Properties

- (void)setYahooWoeidURL:(NSString *)yahooWoeidURL {
    _yahooWoeidURL = yahooWoeidURL;
    
    NSLog(@"Yahoo Woeid URL: %@", yahooWoeidURL);
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("YahooWoeidDownloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:yahooWoeidURL]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSError *serializationError;
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
                NSLog(@"Woeid: %@", dictionary[@"query"][@"results"][@"place"][@"woeid"]);
                
                self.woeid = dictionary[@"query"][@"results"][@"place"][@"woeid"];
                
                NSString *url = [NSString stringWithFormat:@"https://query.yahooapis.com/v1/public/yql?q=select * from weather.forecast where woeid=%@&format=json&diagnostics=true&callback=", self.woeid];
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                self.yahooWeatherURL = url;
            }
        });
    });
}

- (void)setYahooWeatherURL:(NSString *)yahooWeatherURL {
    _yahooWeatherURL = yahooWeatherURL;
    
    NSLog(@"%@", yahooWeatherURL);
    
    [self updateWeather];
}

#pragma mark - Private API

- (void)updateWeather {
    if (self.yahooWeatherURL.length > 0) {
        dispatch_queue_t downloadQueue = dispatch_queue_create("YahooWeatherDownloader", NULL);
        dispatch_async(downloadQueue, ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.yahooWeatherURL]];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data) {
                    NSError *serializationError;
                    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
                    NSLog(@"Weather: %@", dictionary);
                }
            });
        });
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlString = @"https://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20geo.places%20WHERE%20text%3D%22(";
    urlString = [urlString stringByAppendingFormat:@"%.4f", -37.8054];
    urlString = [urlString stringByAppendingString:@"%2C"];
    urlString = [urlString stringByAppendingFormat:@"%.4f", 144.9549];
    urlString = [urlString stringByAppendingString:@")%22&format=json"];
    
    self.yahooWoeidURL = urlString;
}

@end