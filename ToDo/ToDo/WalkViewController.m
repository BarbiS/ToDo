//
//  WalkViewController.m
//  ToDo
//
//  Created by Cubes School 3 on 4/22/16.
//  Copyright © 2016 Cubes School 3. All rights reserved.
//

#import "WalkViewController.h"
#import "Constants.h"
#import "WallkthroughItem.h"
#import "WallkthroughCollectionViewCell.h"

@interface WalkViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControll;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) NSArray *itemsArray;

@end

@implementation WalkViewController

- (IBAction)closeButtonTapped:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:WALKTHROUGH_PRESENTED];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.itemsArray = @[
                        [[WallkthroughItem alloc] initWithText:@"Keep your work organized and\nquickly check your reminders\nwith simple calendar" andImage:[UIImage imageNamed:@"calendar"]],
                        [[WallkthroughItem alloc] initWithText:@"Manage your tasks quick and easy\nfrom your phone" andImage:[UIImage imageNamed:@"phone"]],
                        [[WallkthroughItem alloc] initWithText:@"Quckly add tasks\nfrom home screen" andImage:[UIImage imageNamed:@"tasks"]]
                        ];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UICollectionViewCell *)collectionView: (UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WallkthroughCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    WallkthroughItem *item = [self.itemsArray objectAtIndex:indexPath.item];
    cell.walkthroughItem = item;
    
    self.pageControll.currentPage = indexPath.row;
    
    if (indexPath.row == self.itemsArray.count -1) {
        [UIView animateWithDuration:0.3 animations:^{
            self.closeButton.alpha=1.0;
        }];
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}

@end