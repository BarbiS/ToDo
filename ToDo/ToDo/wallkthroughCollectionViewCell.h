//
//  WallkthroughCollectionViewCell.h
//  ToDo
//
//  Created by Cubes School 3 on 4/25/16.
//  Copyright © 2016 Cubes School 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WallkthroughItem.h"

@interface WallkthroughCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) WallkthroughItem *walkthroughItem;
@end