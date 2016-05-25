//
//  TaskTableViewCell.m
//  ToDo
//
//  Created by Cubes School 3 on 4/15/16.
//  Copyright © 2016 Cubes School 3. All rights reserved.
//

#import "TaskTableViewCell.h"

@implementation TaskTableViewCell

#pragma mark - Properties

- (void)setTask:(Task *)task {
    _task = task;
    
    self.taskTitleLabel.text = task.title;
    self.taskDescriptionLabel.text = task.desc;
    self.taskGroupView.backgroundColor = [Helpers colorForTaskGroup:[task.group integerValue]];
}

@end