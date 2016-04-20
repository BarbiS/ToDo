//
//  BaseViewController.m
//  TableView
//
//  Created by Djuro Alfirevic on 4/18/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

#pragma mark - Properties

- (DataManager *)dataManager {
    return [DataManager sharedInstance];
}

@end