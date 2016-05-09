//
//  ItemDetailsViewController.m
//  Inheritance
//
//  Created by Djuro Alfirevic on 4/29/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "ItemDetailsViewController.h"
#import "WebViewController.h"
#import "MapViewController.h"
#import "AsyncImageView.h"
#import "Article.h"
#import "Product.h"
#import "Restaurant.h"

@interface ItemDetailsViewController()
@property (weak, nonatomic) IBOutlet AsyncImageView *asyncImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *asyncImageViewHeightConstraint;
@end

@implementation ItemDetailsViewController

#pragma mark - Actions

- (IBAction)linkButtonTapped {
    WebViewController *toViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([WebViewController class])];
    toViewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    
    if ([self.item isKindOfClass:[Article class]]) {
        Article *article = (Article *)self.item;
        toViewController.url = article.link;
    } else if ([self.item isKindOfClass:[Product class]]) {
        Product *product = (Product *)self.item;
        toViewController.url = product.imageURL;
    }
    
    [self presentViewController:toViewController animated:YES completion:NULL];
}

- (IBAction)mapButtonTapped {
    MapViewController *toViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([MapViewController class])];
    toViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    toViewController.item = self.item;
    [self presentViewController:toViewController animated:YES completion:NULL];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.asyncImageView.imageURL = self.item.imageURL;
    self.titleLabel.text = self.item.title;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.descTextView.text = [self.item description];
    
    if ([self.item isKindOfClass:[Restaurant class]]) {
        self.asyncImageViewHeightConstraint.constant = 0.0f;
        [self.view layoutIfNeeded];
    }
}

@end