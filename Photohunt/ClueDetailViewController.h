//
//  ClueDetailViewController.h
//  Photohunt
//
//  Created by Sean McGary on 4/6/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppCell.h"

@interface ClueDetailViewController : UITableViewController

@property (strong, nonatomic) NSDictionary *clueData;
@property (readwrite, assign) BOOL showBonus;
@property (strong, nonatomic) NSMutableArray *sections;

- (id) initWithClueData: (NSDictionary *) clue: (BOOL) showBonus;

- (void) toggleBonus: (BOOL) show;

@end
