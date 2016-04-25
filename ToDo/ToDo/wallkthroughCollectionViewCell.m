//
//  WallkthroughCollectionViewCell.m
//  ToDo
//
//  Created by Cubes School 3 on 4/25/16.
//  Copyright © 2016 Cubes School 3. All rights reserved.
//

#import "WallkthroughCollectionViewCell.h"

@implementation WallkthroughCollectionViewCell

- (void)setWalkthroughItem:(WallkthroughItem *)walkthroughItem {
    _walkthroughItem = walkthroughItem;
    
    self.imageView.image = walkthroughItem.image;
    self.textLabel.text = walkthroughItem.text;
}

@end