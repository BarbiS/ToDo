//
//  BaseViewController.h
//  TableView
//
//  Created by Djuro Alfirevic on 4/18/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface BaseViewController : UIViewController
@property (strong, nonatomic) DataManager *dataManager;
@end