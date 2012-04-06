//
//  ClueSheet.h
//  Photohunt
//
//  Created by Sean McGary on 4/5/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClueData.h"

@interface ClueSheet : NSObject

@property (strong, nonatomic) NSMutableArray *clueList;

// list of tags to display 
@property (strong, nonatomic) NSMutableArray *tagList;

// all clues associated with each tag
@property (strong, nonatomic) NSMutableDictionary *tagsWithClues;

- (id) init;

- (void) parseClueJSON: (NSMutableDictionary *) json;

- (int) numClues;

- (int) numTags;

- (BOOL) tagExists: (NSString *) tag;

- (void) persistClueSheet;

- (void) restoreClueSheet;

- (NSArray *) getCluesForTag: (NSString *) tag;

@end
