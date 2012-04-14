//
//  ClueDetailViewController.h
//  Photohunt
//
//  Created by Sean McGary on 4/6/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppCell.h"
#import "AppHelper.h"

@interface ClueDetailViewController : UITableViewController

@property (strong, nonatomic) NSDictionary *clueData;
@property (readwrite, assign) BOOL showBonus;
@property (strong, nonatomic) NSMutableArray *sections;

@property (strong, nonatomic) NSMutableDictionary *photoData;

@property (strong, nonatomic) NSMutableDictionary *selectionStatus;

// flag marking the "No Bonus" button
@property (readwrite, assign) BOOL noBonusSelected;
@property (strong, nonatomic) NSMutableDictionary *photoClueData;
@property (readwrite, assign) BOOL clueIsSelected;

@property (readwrite, assign) BOOL editingPhotoClues;

- (id) initWithClueData: (NSDictionary *) clue: (BOOL) showBonus;

- (id) initWithClueData: (NSDictionary *) clue withPhotoData: (NSMutableDictionary *) photoData;

- (void) toggleBonus: (BOOL) show;

- (void) parseSections: (NSDictionary *) clue;

- (IBAction)saveClue:(id)sender;

-(int)countSelectedBonuses;

@end
