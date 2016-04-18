//
//  DataManager.m
//  TableView
//
//  Created by Djuro Alfirevic on 4/18/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "DataManager.h"
#import "Designer.h"

@implementation DataManager

#pragma mark - Properties

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
        
        Designer *designerOne = [[Designer alloc] initWithName:@"Tom Ford" imageURL:@"https://upload.wikimedia.org/wikipedia/commons/9/98/Tom_Ford_cropped_2009.jpg" andGender:MALE_GENDER];
        Designer *designerTwo = [[Designer alloc] initWithName:@"Victoria Beckham" imageURL:@"http://static2.therichestimages.com/cdn/600/600/100/c/wp-content/uploads/2011/06/victoria_beckham_bob_brown_bla.jpg" andGender:FEMALE_GENDER];
        Designer *designerThree = [[Designer alloc] initWithName:@"Stella McCartney" imageURL:@"https://upload.wikimedia.org/wikipedia/commons/0/08/Stella_McCartney_2014_(cropped).jpg" andGender:FEMALE_GENDER];
        
        [_itemsArray addObject:designerOne];
        [_itemsArray addObject:designerTwo];
        [_itemsArray addObject:designerThree];
    }
    
    return _itemsArray;
}

#pragma mark - Public API

+ (DataManager *)sharedInstance {
    static DataManager *sharedManager;
    
    @synchronized(self)	{
        if (sharedManager == nil) {
            sharedManager = [[DataManager alloc] init];
        }
    }
    
    return sharedManager;
}

- (NSArray *)femaleDesigners {
    NSMutableArray *resultsArray = [[NSMutableArray alloc] init];
    
    for (Designer *designer in self.itemsArray) {
        if (designer.gender == FEMALE_GENDER) {
            [resultsArray addObject:designer];
        }
    }
    
    return resultsArray;
}

- (NSArray *)maleDesigners {
    NSMutableArray *resultsArray = [[NSMutableArray alloc] init];
    
    for (Designer *designer in self.itemsArray) {
        if (designer.gender == MALE_GENDER) {
            [resultsArray addObject:designer];
        }
    }
    
    return resultsArray;
}

@end