//
//  ClueSheet.m
//  Photohunt
//
//  Created by Sean McGary on 4/5/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "ClueSheet.h"

@implementation ClueSheet

@synthesize clueList;
@synthesize tagList;
@synthesize tagsWithClues;

- (id) init {
    self = [super init];
    
    if(self){
        clueList = [[NSMutableArray alloc] init];
        tagList = [[NSMutableArray alloc] init];
        tagsWithClues = [[NSMutableDictionary alloc] init];
        
    }
    
    return self;
}

- (void) parseClueJSON: (NSMutableDictionary *) json {
    
    if([[json objectForKey:@"code"] integerValue] == 0){
        for(id obj in [json objectForKey:@"data"]){
            // create clue list of ClueData objects
            //ClueData *clue = [[ClueData alloc] initWithClueData:obj];
            
            [clueList addObject:obj];
            
            // parse out clues
            for(id tag in [obj objectForKey:@"tags"]){
                if([self tagExists:tag] == NO){
                    [tagList addObject:tag];
                }
            }
            
            // parse clues into tag categories
            for(id tag in tagList){
                NSMutableArray *tagClues = [[NSMutableArray alloc] init];
                
                for(id clueData in clueList){
                    
                    NSMutableDictionary *clue = [[NSMutableDictionary alloc] initWithDictionary:clueData];
                    
                    NSArray *clueTags = [[NSArray alloc] initWithArray:[clue objectForKey:@"tags"]];
                    
                    for(NSString *t in clueTags){
                        if([t isEqualToString:tag]){
                            [tagClues addObject:clueData];
                        }
                    }
                }
                
                [tagsWithClues setObject:tagClues forKey:tag];
            }
        }
        
        [self persistClueSheet];
    }
}

- (int) numClues {
    //NSLog(@"Clue list count: %@", [clueList count]);
    return [clueList count];
    //return 1;
}

- (int) numTags {
    return [tagList count];
}

- (BOOL) tagExists: (NSString *) tag {
    for(id obj in tagList){
        if([obj isEqualToString:tag]){
            return YES;
        }
    }
    
    return NO;
}

- (NSArray *) getCluesForTag: (NSString *) tag {
    NSArray *clues = [[NSArray alloc] initWithArray:[tagsWithClues objectForKey:tag]];
    
    return clues;
}

- (void) persistClueSheet {
    // bundle clueList, tagList, and tagsWithClues into a dictionary
    NSMutableDictionary *bundle = [[NSMutableDictionary alloc] init];
    
    [bundle setObject:clueList forKey:@"clueList"];
    [bundle setObject:tagList forKey:@"tagList"];
    [bundle setObject:tagsWithClues forKey:@"tagsWithClues"];
    
    [AppHelper saveClueSheet:bundle];
}

- (void) getStoredClueSheet {
    NSMutableDictionary *storedClues = [[NSMutableDictionary alloc] initWithDictionary:[AppHelper getClueSheet]];
    
    clueList = [storedClues objectForKey:@"clueList"];
    tagList = [storedClues objectForKey:@"tagList"];
    tagsWithClues = [storedClues objectForKey:@"tagsWithClues"];
    
}


@end
