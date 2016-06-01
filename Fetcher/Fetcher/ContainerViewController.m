//
//  ContainerViewController.m
//  Fetcher
//
//  Created by Djuro Alfirevic on 6/1/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "ContainerViewController.h"
#import "SideMenuViewController.h"
#import "HomeViewController.h"
#import "Constants.h"

@interface ContainerViewController()
@property (strong, nonatomic) SideMenuViewController *sideMenuViewController;
@property (strong, nonatomic) UINavigationController *homeNavigationController;
@end

@implementation ContainerViewController

#pragma mark - Private API

- (void)configureSideMenuViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.sideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SideMenuViewController class])];
    
    // View controller containment
    [self addChildViewController:self.sideMenuViewController];
    [self.view addSubview:self.sideMenuViewController.view];
    [self.sideMenuViewController didMoveToParentViewController:self];
}

- (void)configureHomeViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.homeNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"HomeNavigationController"];
    
    // View controller containment
    [self addChildViewController:self.homeNavigationController];
    [self.view addSubview:self.homeNavigationController.view];
    [self.homeNavigationController didMoveToParentViewController:self];
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserverForName:OPEN_MENU_NOTIFICATION
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note)
    {
        if (self.sideMenuViewController.isOpened) {
            [[NSNotificationCenter defaultCenter] postNotificationName:CLOSE_MENU_NOTIFICATION object:nil];
            return;
        }
        
        self.sideMenuViewController.isOpened = YES;
        
        [UIView animateWithDuration:0.3f
                              delay:0.0f
             usingSpringWithDamping:0.4
              initialSpringVelocity:7.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGRect frame = self.homeNavigationController.view.frame;
                             frame.origin.x = [UIScreen mainScreen].bounds.size.width - kMenuOffset;
                             self.homeNavigationController.view.frame = frame;
                         }
                         completion:NULL];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:CLOSE_MENU_NOTIFICATION
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note)
    {
        self.sideMenuViewController.isOpened = NO;
        
        [UIView animateWithDuration:0.3f
                              delay:0.0f
             usingSpringWithDamping:0.4
              initialSpringVelocity:7.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGRect frame = self.homeNavigationController.view.frame;
                             frame.origin.x = 0;
                             self.homeNavigationController.view.frame = frame;
                         }
                         completion:NULL];
    }];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerForNotifications];
    [self configureSideMenuViewController];
    [self configureHomeViewController];
}

@end