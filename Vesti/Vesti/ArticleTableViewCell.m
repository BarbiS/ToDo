//
//  ArticleTableViewCell.m
//  Vesti
//
//  Created by Djuro Alfirevic on 4/26/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "ArticleTableViewCell.h"

@implementation ArticleTableViewCell

#pragma mark - Properties

- (void)setArticle:(Article *)article {
    _article = article;
    
    self.articleTitleLabel.text = article.title;
    self.asyncImageView.imageURL = article.imageURL;
}

@end