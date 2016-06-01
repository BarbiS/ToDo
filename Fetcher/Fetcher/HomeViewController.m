//
//  HomeViewController.m
//  Fetcher
//
//  Created by Djuro Alfirevic on 6/1/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "HomeViewController.h"
#import "Article.h"
#import "Constants.h"
#import "SideMenuViewController.h"

@interface HomeViewController() <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinnerView;
@property (strong, nonatomic) Article *article;
@end

@implementation HomeViewController

#pragma mark - Actions

- (IBAction)menuButtonTapped {
    [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_MENU_NOTIFICATION object:nil];
}

#pragma mark - Private API

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserverForName:OPEN_ARTICLE_NOTIFICATION
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note)
    {
        self.article = (Article *)note.object;
        
        [self.spinnerView startAnimating];
        
        if (self.article) {
            NSURL *url = [NSURL URLWithString:self.article.link];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [self.webView loadRequest:request];
        }
    }];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerForNotifications];
    
    [self.spinnerView stopAnimating];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.spinnerView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinnerView stopAnimating];
}

@end