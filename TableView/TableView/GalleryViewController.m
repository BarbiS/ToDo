//
//  GalleryViewController.m
//  TableView
//
//  Created by Djuro Alfirevic on 4/18/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "GalleryViewController.h"
#import "DesignerCollectionViewCell.h"
#import "DataManager.h"

@interface GalleryViewController() <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) DataManager *dataManager;
@end

@implementation GalleryViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataManager = [DataManager sharedInstance];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataManager.itemsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DesignerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.designer = [self.dataManager.itemsArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGRect screenSize = [UIApplication sharedApplication].keyWindow.bounds;
    
    return CGSizeMake(screenSize.size.width, screenSize.size.height);
}

@end