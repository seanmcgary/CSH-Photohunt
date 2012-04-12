//
//  AppHelper.h
//  Photohunt
//
//  Created by Sean McGary on 4/7/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#include <math.h>
static inline double radians (double degrees) {
    return degrees * M_PI/180;
}

#import <Foundation/Foundation.h>


@interface AppHelper : NSObject

// get the game state. if a game is in progress
+(BOOL) gameInProgress;

+(void) setGameProgress: (BOOL) game;

+(void)saveClueSheet: (NSMutableDictionary *)clueSheet;

+(NSMutableDictionary *)getClueSheet;

+(void) setGameData: (NSMutableDictionary *) gameData;

// returns nil if the field doesnt exist
+(id)getGameData;

+(NSString *) getTeamToken;

+(void) endGame;

+(id) getSavedPhotos;

// add a photo to the saved data
+(id) savePhotoData: (NSMutableDictionary *) photoData;

+(void) saveAllPhotos: (NSMutableArray *) photoList;

+(void) incrementPhotoCount;

+(void) incrementJudgedPhotoCount;

+(void) decrementJudgedPhotoCount;

+(void) markPhotoAsUploaded: (NSString *)photoName;

+(void) updatePhoto: (NSDictionary *)photoData;

+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSize:(CGSize)newSize;

@end
