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
    if([[json objectForKey:@"code"] isKindOfClass:[NSNumber class]]){
        NSLog(@"integer");
    }
    
    if([[json objectForKey:@"code"] integerValue] == 0){
        for(id obj in [json objectForKey:@"data"]){
            // create clue list of ClueData objects
            ClueData *clue = [[ClueData alloc] initWithClueData:obj];
            
            [clueList addObject:clue];
            
            // parse out clues
            for(id tag in [obj objectForKey:@"tags"]){
                if([self tagExists:tag] == NO){
                    [tagList addObject:tag];
                }
            }
            
            // parse clues into tag categories
            for(id tag in tagList){
                NSMutableArray *tagClues = [[NSMutableArray alloc] init];
                
                for(ClueData *clueData in clueList){
                    
                    NSMutableDictionary *clue = [[NSMutableDictionary alloc] initWithDictionary:clueData.clue];
                    
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
        
        //[self persistClueSheet];
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

- (void) persistClueSheet {
    // bundle clueList, tagList, and tagsWithClues into a dictionary
    NSMutableDictionary *bundle = [[NSMutableDictionary alloc] init];
    
    [bundle setObject:clueList forKey:@"clueList"];
    [bundle setObject:tagList forKey:@"tagList"];
    [bundle setObject:tagsWithClues forKey:@"tagsWithClues"];
    
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:bundle forKey:@"clueListBundle"];
    [archiver finishEncoding];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:data forKey:@"clueList"];
    [defaults synchronize];
}

- (void) restoreClueSheet {
    
}


@end
