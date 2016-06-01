//
//  SideMenuViewController.h
//  Fetcher
//
//  Created by Djuro Alfirevic on 6/1/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const OPEN_MENU_NOTIFICATION = @"OPEN_MENU_NOTIFICATION";
static NSString *const CLOSE_MENU_NOTIFICATION = @"CLOSE_MENU_NOTIFICATION";
#define kMenuOffset 100.0f

@interface SideMenuViewController : UIViewController
@property (nonatomic) BOOL isOpened;
@end