//
//  ProductsViewController.m
//  Inheritance
//
//  Created by Djuro Alfirevic on 4/29/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "ProductsViewController.h"
#import "ProductTableViewCell.h"
#import "Product.h"

static NSString *const TOKEN_URL    = @"https://shop.maxi.rs/phone-home-gettoken";
static NSString *const PRODUCTS_URL = @"https://shop.maxi.rs/phone-home-products";

@interface ProductsViewController()
@property (strong, nonatomic) NSString *token;
@end

@implementation ProductsViewController

#pragma mark - Properties

- (void)setToken:(NSString *)token {
    _token = token;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:PRODUCTS_URL]];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSData *postData = [[NSString stringWithFormat:@"token=%@", token] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
          if (!error) {
              if (data) {
                  NSError *serializationError;
                  NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
                  
                  NSDictionary *dataDictionary = dictionary[@"data"];
                  NSString *status = dataDictionary[@"status"];
                  
                  NSLog(@"%@", dataDictionary);
                  
                  if ([status isEqualToString:@"done"]) { // No errors
                      dispatch_async(dispatch_get_main_queue(), ^{
                          if (dataDictionary[@"results"]) {
                              for (NSDictionary *productDictionary in dataDictionary[@"results"]) {
                                  Product *product = [[Product alloc] initWithDictionary:productDictionary];
                                  [self.itemsArray addObject:product];
                              }
                              
                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                              
                              [self.tableView reloadData];
                          }
                      });
                  } else {
                      if (dataDictionary) {
                          dispatch_async(dispatch_get_main_queue(), ^{
                              NSDictionary *userInfo = @{NSLocalizedDescriptionKey : dataDictionary[@"error"]};
                              NSError *beError = [NSError errorWithDomain:@"Greška"
                                                                     code:404
                                                                 userInfo:userInfo];
                              
                              if (![beError.localizedDescription isEqualToString:@"The Token is not valid"]) {
                                  NSLog(@"%@", [beError localizedDescription]);
                              } else {
                                  NSLog(@"The Token is not valid");
                              }
                          });
                      }
                  }
              }
          } else {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"%@", [error localizedDescription]);
              });
          }
      }] resume];
}

#pragma mark - Public API

- (void)loadData {
    [super loadData];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:TOKEN_URL]];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSData *postData = [@"username=phone&password=VRf68vuFNAXWXjTg@!" dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
          if (!error) {
              if (data) {
                  NSError *serializationError;
                  NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
                  
                  NSDictionary *dataDictionary = dictionary[@"data"];
                  NSString *status = dataDictionary[@"status"];
                  
                  if ([status isEqualToString:@"done"]) { // No errors
                      dispatch_async(dispatch_get_main_queue(), ^{
                          NSLog(@"Token: %@", dataDictionary[@"results"][@"token"]);
                          self.token = dataDictionary[@"results"][@"token"];
                      });
                  } else {
                      if (dataDictionary) {
                          dispatch_async(dispatch_get_main_queue(), ^{
                              NSDictionary *userInfo = @{NSLocalizedDescriptionKey : dataDictionary[@"error"]};
                              NSError *beError = [NSError errorWithDomain:@"Greška"
                                                                     code:404
                                                                 userInfo:userInfo];
                              
                              if (![beError.localizedDescription isEqualToString:@"The Token is not valid"]) {
                                  NSLog(@"%@", [beError localizedDescription]);
                              } else {
                                  NSLog(@"The Token is not valid");
                              }
                          });
                      }
                  }
              }
          } else {
              dispatch_async(dispatch_get_main_queue(), ^{
                  NSLog(@"%@", [error localizedDescription]);
              });
          }
      }] resume];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.item = [self.itemsArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    [self performSegueWithIdentifier:@"ProductDetailsSegue" sender:self];
}

@end