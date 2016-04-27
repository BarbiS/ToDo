//
//  ArticleDetailsViewController.m
//  Vesti
//
//  Created by Djuro Alfirevic on 4/26/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "ArticleDetailsViewController.h"
#import "WebViewController.h"
#import "AsyncImageView.h"

@interface ArticleDetailsViewController()
@property (weak, nonatomic) IBOutlet AsyncImageView *asyncImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;
@end

@implementation ArticleDetailsViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.asyncImageView.imageURL = self.article.imageURL;
    self.titleLabel.text = self.article.title;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.descTextView.text = self.article.desc;
}

#pragma mark - Segue management

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"WebSegue"]) {
        WebViewController *toViewController = segue.destinationViewController;
        toViewController.article = self.article;
    }
}

@end