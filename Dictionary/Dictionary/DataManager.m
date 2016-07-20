//
//  DataManager.m
//  Dictionary
//
//  Created by Djuro Alfirevic on 7/20/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "DataManager.h"
#import "Player.h"

@interface DataManager()
@property (strong, nonatomic) NSMutableArray *playersArray;
@end

@implementation DataManager

#pragma mark - Properties

- (NSMutableArray *)playersArray {
    if (!_playersArray) {
        _playersArray = [[NSMutableArray alloc] init];
    }
    
    return _playersArray;
}

#pragma mark - Designated Initializer

+ (instancetype)sharedInstance {
    static DataManager *sharedManager;
    
    @synchronized(self)	{
        if (sharedManager == nil) {
            sharedManager = [[DataManager alloc] init];
        }
    }
    
    return sharedManager;
}

#pragma mark - Public API

- (void)fillDummyData {
    [self.playersArray addObject:[[Player alloc] initWithFirstName:@"Nikola" andLastName:@"Miric"]];
    [self.playersArray addObject:[[Player alloc] initWithFirstName:@"Marko" andLastName:@"Simic"]];
    [self.playersArray addObject:[[Player alloc] initWithFirstName:@"Nebojsa" andLastName:@"Gujanicic"]];
    [self.playersArray addObject:[[Player alloc] initWithFirstName:@"Teodora" andLastName:@"Garasanin"]];
    [self.playersArray addObject:[[Player alloc] initWithFirstName:@"Vanja" andLastName:@"Ruzic"]];
    [self.playersArray addObject:[[Player alloc] initWithFirstName:@"Marko" andLastName:@"Rankovic"]];
    [self.playersArray addObject:[[Player alloc] initWithFirstName:@"Barbara" andLastName:@"Strugarevic"]];
    [self.playersArray addObject:[[Player alloc] initWithFirstName:@"Borko" andLastName:@"Bendic"]];
    [self.playersArray addObject:[[Player alloc] initWithFirstName:@"Vladimir" andLastName:@"Vukcevic"]];
    [self.playersArray addObject:[[Player alloc] initWithFirstName:@"Djuro" andLastName:@"Alfirevic"]];
}

- (NSMutableDictionary *)prepareDictionary {
    NSMutableDictionary *resultsDictionary = [NSMutableDictionary dictionary];
    
    NSArray *lettersArray = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    
    for (NSString *letter in lettersArray) {
        NSArray *playersArray = [self getPlayersWhichNameBeginsWith:letter];
        if (playersArray.count > 0) {
            [resultsDictionary setValue:playersArray forKey:letter];
        }
    }
    
    return resultsDictionary;
}

- (NSArray *)getPlayersWhichNameBeginsWith:(NSString *)letter {
    NSMutableArray *playersArray = [NSMutableArray array];
    
    for (Player *player in self.playersArray) {
        if ([player.fName hasPrefix:letter]) {
            [playersArray addObject:player];
        }
    }
    
    return playersArray;
}

@end