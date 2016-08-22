//
//  AppDelegate.m
//  XIB
//
//  Created by Djuro Alfirevic on 8/22/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ViewController *viewController = [[ViewController alloc] initWithNibName:NSStringFromClass([ViewController class]) bundle:[NSBundle mainBundle]];
    
    [self.window makeKeyAndVisible];
    self.window.rootViewController = viewController;
    
    return YES;
}

@end