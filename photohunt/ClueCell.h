//
//  ClueCell.h
//  Photohunt
//
//  Created by Sean McGary on 4/5/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClueCell : UITableViewCell

@property (strong, nonatomic) NSDictionary *clueInfo;
@property (strong, nonatomic) NSMutableDictionary *photoData;
@property (readwrite, assign) BOOL isEditingClues;

- (id) initWithClueInfo: (NSDictionary *)clueInfo;

- (id) initWithClueInfo: (NSDictionary *)clueInfo andPhotoData:(NSMutableDictionary *) photoData;

@end
