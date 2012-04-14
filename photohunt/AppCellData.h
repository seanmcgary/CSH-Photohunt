//
//  AppCellData.h
//  Photohunt
//
//  Created by Sean McGary on 3/25/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppCellData : NSObject

@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *value;

- (id) initWithData: (NSString *) category: (NSString *) value;

@end
