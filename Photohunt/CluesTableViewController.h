//
//  CluesTableViewController.h
//  Photohunt
//
//  Created by Sean McGary on 4/6/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClueCell.h"
#import "ClueDetailViewController.h"

@interface CluesTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *clueList;
@property (strong, nonatomic) NSMutableDictionary *photoData;
@property (readwrite, assign) BOOL isEditingClues;

- (id) initWithClues: (NSArray *) clueList;

- (id) initWithCluesForEditing: (NSArray *) clueList withPhotoData: (NSMutableDictionary *)photoData;



@end
