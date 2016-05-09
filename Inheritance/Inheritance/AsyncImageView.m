//
//  AsyncImageView.m
//  Inheritance
//
//  Created by Djuro Alfirevic on 4/29/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "AsyncImageView.h"

@implementation AsyncImageView

#pragma mark - Properties

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("ImageDownloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageURL]];
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
    });
}

@end
