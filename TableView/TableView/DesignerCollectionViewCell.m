//
//  DesignerCollectionViewCell.m
//  TableView
//
//  Created by Djuro Alfirevic on 4/18/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "DesignerCollectionViewCell.h"

@implementation DesignerCollectionViewCell

#pragma mark - Properties

- (void)setDesigner:(Designer *)designer {
    _designer = designer;
    
    self.designerNameLabel.text = designer.name;
    self.designerImageView.imageURL = designer.imageURL;
}

#pragma mark - Cell lifecycle

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.designerImageView.image = nil;
}

@end