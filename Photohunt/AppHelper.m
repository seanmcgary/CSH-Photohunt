//
//  AppHelper.m
//  Photohunt
//
//  Created by Sean McGary on 4/7/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "AppHelper.h"

@implementation AppHelper

+(BOOL) gameInProgress 
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL game = [defaults boolForKey:@"PH_gameState"];
    
    NSLog(@"Game: %u", game);
    
    return game;
}

// YES = game is in progress
// NO = game is not in progress
+(void) setGameProgress: (BOOL) game 
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:game forKey:@"PH_gameState"];
    
    [defaults synchronize];
}

+(void)saveClueSheet: (NSMutableDictionary *)clueSheet
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:clueSheet forKey:@"PH_clueSheet"];
    [archiver finishEncoding];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:data forKey:@"PH_clueSheet"];
    [defaults synchronize];
}

+(NSMutableDictionary *)getClueSheet
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"here");
    NSMutableData *clueSheetData = [defaults objectForKey:@"PH_clueSheet"];

    
    if(!clueSheetData){
        NSLog(@"no clue sheet found");
    }
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:clueSheetData];
    
    NSMutableDictionary *clues = [[NSMutableDictionary alloc] initWithDictionary:[unarchiver decodeObjectForKey:@"PH_clueSheet"]];
    [unarchiver finishDecoding];
    return clues;
}

+(void) setGameData: (NSMutableDictionary *) gameData 
{
    NSLog(@"setting game data");
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:gameData forKey:@"PH_gameData"];
    [archiver finishEncoding];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:data forKey:@"PH_gameData"];
    [defaults synchronize];
}

+(id)getGameData 
{
    NSLog(@"Getting game data");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableData *gameDataData = [defaults objectForKey:@"PH_gameData"];
    NSLog(@"here");
    //[defaults removeObjectForKey:@"PH_gameData"];
    //return nil;
    
    if(!gameDataData){
        NSLog(@"gamedata nil");
        return nil;
    }
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:gameDataData];
    
    NSMutableDictionary *gameData = [unarchiver decodeObjectForKey:@"PH_gameData"];
    [unarchiver finishDecoding];
     
    
    return gameData;
}

+(void) endGame
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"PH_gameData"];
    [defaults setBool:NO forKey:@"PH_gameState"];
    
    // delete other data here too
    
    [defaults synchronize];
    
    
}

@end
