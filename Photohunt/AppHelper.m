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
    
    NSLog(@"Game: %@", game);
    
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

+(void)saveClueSheet: (NSMutableData *)clueSheet
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:clueSheet forKey:@"PH_clueSheet"];
    [defaults synchronize];
}

+(NSMutableData *)getClueSheet
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults objectForKey:@"PH_clueSheet"];
}

@end
