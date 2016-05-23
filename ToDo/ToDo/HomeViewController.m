//
//  HomeViewController.m
//  ToDo
//
//  Created by Cubes School 3 on 4/8/16.
//  Copyright © 2016 Cubes School 3. All rights reserved.
//

#import "HomeViewController.h"
#import "TaskTableViewCell.h"
#import "Constants.h"
#import "MenuView.h"
#import "DataManager.h"
#import "Task.h"


@interface HomeViewController ()  <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MenuViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *badgeImageView;
@property (weak, nonatomic) IBOutlet MenuView *menuView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *badgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) NSMutableArray *itemsArray;

@end

@implementation HomeViewController

#pragma mark - Properties

- (NSMutableArray *)itemsArray {
    return [[DataManager sharedInstance] fetchEntity:NSStringFromClass([Task class]) withFilter:nil withSortAsc:YES forKey:@"date"];
}

#pragma mark - private APi

- (void)configureBadge {
    self.badgeImageView.alpha = (self.itemsArray.count == 0) ? ZERO_VALUE : 1.0;
    self.badgeLabel.alpha = (self.itemsArray.count == 0) ? ZERO_VALUE : 1.0;
    self.badgeLabel.text = [NSString stringWithFormat:@"%ld", self.itemsArray.count];
}

- (void)configureProfileImage {
    self.profileImageView.clipsToBounds=YES;
    self.profileImageView.layer.cornerRadius=self.profileImageView.frame.size.width/2;
    
    // Set profile image, if NSData exists in NSUserDefaults
    if ([[NSUserDefaults standardUserDefaults]objectForKey:USER_IMAGE]) {
        // NSData was previosly in NSUserDefaults when user selected an image
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:USER_IMAGE];
        
        self.profileImageView.image=[[UIImage alloc]initWithData:data];
    }
}

- (void)configureWelcomeLabel {
    if ([Helpers isMorning]) {
        self.welcomeLabel.text = @"Good Morning!";
    } else {
        self.welcomeLabel.text = @"Good afternoon";
    }
}

# pragma mark - View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(pickImage)];
    tap.numberOfTapsRequired=1;
    [self.profileImageView addGestureRecognizer:tap];
    
    [self.tableView reloadData];
    
 

   // dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      //  [self performSegueWithIdentifier:@"StatisticsSegue" sender:self];
     //   [self presentErrorWithTitle:@"Hey" andError:@"Nema konekcije"];
   // });
    
   // dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     //   [self performSegueWithIdentifier:@"AboutSegue" sender:self];
    //});
    
    /*dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"TaskDetailsSegue" sender:self];
    });*/
    
    self.menuView.delegate = self;

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    if (![[NSUserDefaults standardUserDefaults] boolForKey:WALKTHROUGH_PRESENTED]) {
        [self performSegueWithIdentifier:@"WalkthroughSegue" sender:self];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

# pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.taskTitleLabel.text= [NSString stringWithFormat:@"Red %ld", indexPath.row];
    
    switch (indexPath.row) {
        case COMPLETED_TASK_GROUP:
            cell.taskGroupView.backgroundColor = kTurquoiseColor;
            break;
            
        case NOT_COMPLETED_TASK_GROUP:
            cell.taskGroupView.backgroundColor = kOrangeColor;
            break;
            
        case IN_PROGRESS_TASK_GROUP:
            cell.taskGroupView.backgroundColor = kPurpleColor;
            break;
            
        default:
            cell.taskGroupView.backgroundColor = kTurquoiseColor;
            break;
    }
    
    return cell;
}

# pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return 70;
}

- (void)pickImage {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Choose source"
                                                                 message:nil
                                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction: [UIAlertAction actionWithTitle:@"Photo library"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction * _Nonnull action)
    {
        UIImagePickerController *picker= [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }]];
    
    if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear] ||
        [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
        
        [alert addAction: [UIAlertAction actionWithTitle:@"Camera"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * _Nonnull action)
        {
             UIImagePickerController *picker= [[UIImagePickerController alloc] init];
             picker.sourceType = UIImagePickerControllerSourceTypeCamera;
             picker.delegate = self;
             picker.allowsEditing = YES;
             [self presentViewController:picker animated:YES completion:nil];
        }]];
    }

    [alert addAction: [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
    
    // Present alert controller
    [self presentViewController:alert animated:YES completion:nil];
}

# pragma mark - UIImagePickerControllerDelegate

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    self.profileImageView.image=image;
    
    // Concert select UIImage
    NSData *data= UIImageJPEGRepresentation(image, 1.0);
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:USER_IMAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // After picking image, close imagePickerController
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MenuViewDelegate

- (void)menuViewOptionTapped:(MenuOption)option {
    switch (option) {
        case TSDK_DETAILS_MENU_OPTION: {
            [self performSegueWithIdentifier:@"TaskDetailsSegue" sender:nil];
        }break;
            
        case ABOUT_MENU_OPTION: {
            [self performSegueWithIdentifier:@"AboutSegue" sender:nil];
        }break;
            
        case STATISTICS_MENU_OPTION: {
            [self performSegueWithIdentifier:@"StatisticsSegue" sender:nil];
        }break;
            
        case WALKTHROUGH_MENU_OPTION: {
            [self performSegueWithIdentifier:@"WalkthroughSegue" sender:nil];
        }break;
            
    }
}
@end