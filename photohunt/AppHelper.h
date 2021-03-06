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
#import <QuartzCore/QuartzCore.h>




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

+(void) markPhotoAsJudged: (NSString *)photoName;

+(void) setPhotoPhotoId: (NSString *)photoId photoName:(NSString *) photoName;

+(void) setPhotoNotes: (NSString *) notes forPhotoName:(NSString *)photoName;

+(void) setClueForPhoto: (NSMutableDictionary *) newClue forPhotoName: (NSString *)photoName; 

+(void) removeClueForPhoto: (NSMutableDictionary *)clue forPhotoName: (NSString *)photoName;

+(void) unmarkPhotoAsJudged: (NSString *)photoName;

+(void) updatePhoto: (NSDictionary *) photoData;

+(id) getPhotoDataForPhotoName: (NSString *)photoName;

+(UIImage *)imageWithImage: (UIImage*)sourceImage scaledToSize:(CGSize)newSize;

+(void) deleteAllPhotos;

+(void) deletePhoto: (NSString *)photoPath;



@end
