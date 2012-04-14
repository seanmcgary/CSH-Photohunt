//
//  AppCellData.m
//  Photohunt
//
//  Created by Sean McGary on 3/25/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "AppCellData.h"

@implementation AppCellData

@synthesize category;
@synthesize value;

- (id) initWithData: (NSString *) category: (NSString *) value
{
    self.category = category;
    self.value = value;
    
    return self;
}

@end
