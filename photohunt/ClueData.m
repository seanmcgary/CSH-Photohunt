//
//  ClueData.m
//  Photohunt
//
//  Created by Sean McGary on 4/5/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "ClueData.h"

@implementation ClueData

@synthesize clue;

- (id) init {
    self = [super init];
    
    if(self){
        
    }
    
    return self;
}

- (id) initWithClueData: (NSMutableDictionary *) clueData {
    self = [self init];
    
    if(self){
        clue = [[NSMutableDictionary alloc] initWithDictionary:clueData];
    }
    
    return self;
}

@end
