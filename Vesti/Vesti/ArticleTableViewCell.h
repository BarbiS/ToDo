//
//  ArticleTableViewCell.h
//  Vesti
//
//  Created by Djuro Alfirevic on 4/26/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "Article.h"

@interface ArticleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet AsyncImageView *asyncImageView;
@property (weak, nonatomic) IBOutlet UILabel *articleTitleLabel;
@property (strong, nonatomic) Article *article;
@end