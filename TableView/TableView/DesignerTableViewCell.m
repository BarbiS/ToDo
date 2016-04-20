//
//  DesignerTableViewCell.m
//  TableView
//
//  Created by Djuro Alfirevic on 4/18/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "DesignerTableViewCell.h"

@implementation DesignerTableViewCell

#pragma mark - Properties

- (void)setDesigner:(Designer *)designer {
    _designer = designer;
    
    self.designerNameLabel.text = designer.name;
    
    self.designerImageView.clipsToBounds = YES;
    self.designerImageView.layer.cornerRadius = self.designerImageView.frame.size.width/2;
    self.designerImageView.imageURL = designer.imageURL;
}

@end