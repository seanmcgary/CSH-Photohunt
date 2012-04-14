//
//  ClueData.h
//  Photohunt
//
//  Created by Sean McGary on 4/5/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClueData : NSObject

@property (strong, nonatomic) NSMutableDictionary *clue;

- (id) init;

- (id) initWithClueData: (NSMutableDictionary *) clueData;

@end
