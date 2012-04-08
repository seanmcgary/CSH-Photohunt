//
//  AppHelper.h
//  Photohunt
//
//  Created by Sean McGary on 4/7/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppHelper : NSObject

// get the game state. if a game is in progre
+(BOOL) gameInProgress;

+(void) setGameProgress: (BOOL) game;

+(void)saveClueSheet: (NSMutableData *)clueSheet;

+(NSMutableData *)getClueSheet;

@end
