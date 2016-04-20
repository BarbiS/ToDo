//
//  DesignerCollectionViewCell.h
//  TableView
//
//  Created by Djuro Alfirevic on 4/18/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "Designer.h"

@interface DesignerCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet AsyncImageView *designerImageView;
@property (weak, nonatomic) IBOutlet UILabel *designerNameLabel;
@property (strong, nonatomic) Designer *designer;
@end