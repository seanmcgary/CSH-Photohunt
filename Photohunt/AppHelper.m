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
    
    //NSLog(@"Game: %u", game);
    
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
    //[defaults setBool:NO forKey:@"PH_savedPhotos"];
    
    [defaults synchronize];
    
    
}

+(id) getTeamToken
{
    NSMutableDictionary *gameData = [AppHelper getGameData];
    
    if(gameData){
        return [gameData objectForKey:@"teamToken"];
    } else {
        return nil;
    }
}

+(id) getSavedPhotos 
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableData *savedPhotoData = [defaults objectForKey:@"PH_savedPhotos"];
    
    if(!savedPhotoData){
        NSLog(@"photo data nil");
        return nil;
    }
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:savedPhotoData];
    
    NSMutableArray *photos = [unarchiver decodeObjectForKey:@"PH_savedPhotos"];
    [unarchiver finishDecoding];
    
    
    if(!photos){
        return nil;
    }
    
    return photos;
    
}


+(id) savePhotoData: (NSMutableDictionary *) photoData
{
    
    NSMutableArray *photoList = [NSMutableArray arrayWithArray:[AppHelper getSavedPhotos]];
    
    NSLog(@"Photo List");
    if(photoList == nil){
        NSLog(@"photo list nil");
        photoList = [[NSMutableArray alloc] init];
    }
    
    [photoList addObject:photoData];
    
    [AppHelper saveAllPhotos:photoList];
    
    return photoData;
}

+(void) saveAllPhotos: (NSMutableArray *) photoList
{
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:photoList forKey:@"PH_savedPhotos"];
    [archiver finishEncoding];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:data forKey:@"PH_savedPhotos"];
    [defaults synchronize];
}



+(void) incrementPhotoCount
{
    NSMutableDictionary *gameData = [AppHelper getGameData];
    
    if(gameData){
        NSNumber *photosTaken = [gameData objectForKey:@"photosTaken"];
        
        int val = [photosTaken intValue];
        
        val++;
        
        photosTaken = [NSNumber numberWithInt:val];
        
        [gameData setObject:photosTaken forKey:@"photosTaken"];
        
        [AppHelper setGameData:gameData];
    }
}

+(void) incrementJudgedPhotoCount
{
    NSMutableDictionary *gameData = [AppHelper getGameData];
    
    if(gameData){
        NSNumber *photosJudged = [gameData objectForKey:@"photosJudged"];
        
        int val = [photosJudged intValue];
        
        val++;
        
        photosJudged = [NSNumber numberWithInt:val];
        
        [gameData setObject:photosJudged forKey:@"photosJudged"];
        
        [AppHelper setGameData:gameData];
    }
}

+(void) decrementJudgedPhotoCount
{
    NSMutableDictionary *gameData = [AppHelper getGameData];
    
    if(gameData){
        NSNumber *photosJudged = [gameData objectForKey:@"photosJudged"];
        
        int val = [photosJudged intValue];
        
        if(val > 0){
            val--;
        }
        
        photosJudged = [NSNumber numberWithInt:val];
        
        [gameData setObject:photosJudged forKey:@"photosJudged"];
        
        [AppHelper setGameData:gameData];
    }
}

+(void) markPhotoAsUploaded: (NSString *)photoName
{
    NSMutableArray *savedPhotos = [[NSMutableArray alloc] initWithArray:[AppHelper getSavedPhotos]];
    
    //NSLog(@"savedPhotos (markAsUploaded)\n%@", savedPhotos);
    
    for(NSMutableDictionary *photo in savedPhotos){
        if([[photo objectForKey:@"photoName"] isEqualToString:photoName]){
            //[photo setObject:[NSNumber numberWithInt:1] forKey:@"hasBeenUploaded"];
            NSMutableDictionary *updatedPhoto = [[NSMutableDictionary alloc] initWithDictionary:photo];
            [updatedPhoto setObject:[NSNumber numberWithInt:1] forKey:@"hasBeenUploaded"];
            [AppHelper updatePhoto:updatedPhoto];
        }
    }
}

+(void) markPhotoAsJudged: (NSString *)photoName
{
    NSMutableArray *savedPhotos = [[NSMutableArray alloc] initWithArray:[AppHelper getSavedPhotos]];
    
    for(NSMutableDictionary *photo in savedPhotos)
    {
        if([[photo objectForKey:@"photoName"] isEqualToString:photoName])
        {
            NSMutableDictionary *updatedPhoto = [[NSMutableDictionary alloc] initWithDictionary:photo];
            [updatedPhoto setObject:[NSNumber numberWithInt:1] forKey:@"judge"];
            [AppHelper updatePhoto:updatedPhoto];
            
            [AppHelper incrementJudgedPhotoCount];
        }
    }
}

+(void) unmarkPhotoAsJudged: (NSString *)photoName
{
    NSMutableArray *savedPhotos = [[NSMutableArray alloc] initWithArray:[AppHelper getSavedPhotos]];
    
    for(NSMutableDictionary *photo in savedPhotos)
    {
        if([[photo objectForKey:@"photoName"] isEqualToString:photoName])
        {
            NSMutableDictionary *updatedPhoto = [[NSMutableDictionary alloc] initWithDictionary:photo];
            [updatedPhoto setObject:[NSNumber numberWithInt:0] forKey:@"judge"];
            [AppHelper updatePhoto:updatedPhoto];
            [AppHelper decrementJudgedPhotoCount];
        }
    }
}

+(void) setPhotoPhotoId: (NSString *)photoId photoName:(NSString *) photoName
{
    NSMutableArray *savedPhotos = [[NSMutableArray alloc] initWithArray:[AppHelper getSavedPhotos]];
    
    for(NSMutableDictionary *photo in savedPhotos)
    {
        if([[photo objectForKey:@"photoName"] isEqualToString:photoName])
        {
            NSMutableDictionary *updatedPhoto = [[NSMutableDictionary alloc] initWithDictionary:photo];
            [updatedPhoto setObject:photoId forKey:@"photoId"];
            [AppHelper updatePhoto:updatedPhoto];
            [AppHelper decrementJudgedPhotoCount];
        }
    }
}

+(void) setPhotoNotes: (NSString *) notes forPhotoName:(NSString *)photoName
{
    NSMutableArray *savedPhotos = [[NSMutableArray alloc] initWithArray:[AppHelper getSavedPhotos]];
    
    for(NSMutableDictionary *photo in savedPhotos)
    {
        if([[photo objectForKey:@"photoName"] isEqualToString:photoName])
        {
            NSMutableDictionary *updatedPhoto = [[NSMutableDictionary alloc] initWithDictionary:photo];
            [updatedPhoto setObject:notes forKey:@"notes"];
            [AppHelper updatePhoto:updatedPhoto];
            [AppHelper decrementJudgedPhotoCount];
        }
    }
}

+(void) updatePhoto: (NSDictionary *) photoData
{
    NSMutableArray *savedPhotos = [[NSMutableArray alloc] initWithArray:[AppHelper getSavedPhotos]];
    
    NSUInteger replaceIndex;
    
    for(NSMutableDictionary *photo in savedPhotos){
        if([[photo objectForKey:@"photoName"] isEqualToString:[photoData objectForKey:@"photoName"]])
        {
            //[savedPhotos replaceObjectAtIndex: withObject:photoData]; 
            replaceIndex = [savedPhotos indexOfObject:photo];
        }
    }
    
    [savedPhotos replaceObjectAtIndex:replaceIndex withObject:photoData];
    
    [AppHelper saveAllPhotos:savedPhotos];
}

// Snagged this from stackoverflow
/*
 
*/
+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSize:(CGSize)newSize
{
    CGFloat targetWidth = newSize.width;
    CGFloat targetHeight = newSize.height;
    
    CGImageRef imageRef = [sourceImage CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    
    if (bitmapInfo == kCGImageAlphaNone) {
        bitmapInfo = kCGImageAlphaNoneSkipLast;
    }
    
    CGContextRef bitmap;
    
    if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
    } else {
        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
        
    }   
    
    if (sourceImage.imageOrientation == UIImageOrientationLeft) {
        CGContextRotateCTM (bitmap, radians(90));
        CGContextTranslateCTM (bitmap, 0, -targetHeight);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationRight) {
        CGContextRotateCTM (bitmap, radians(-90));
        CGContextTranslateCTM (bitmap, -targetWidth, 0);
        
    } else if (sourceImage.imageOrientation == UIImageOrientationUp) {
        // NOTHING
    } else if (sourceImage.imageOrientation == UIImageOrientationDown) {
        CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
        CGContextRotateCTM (bitmap, radians(-180.));
    }
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, targetWidth, targetHeight), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage; 
}

@end
