//
//  CluesViewController.h
//  Photohunt
//
//  Created by Sean McGary on 4/5/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ClueSheet.h"
#import "ClueCell.h"
#import "ClueData.h"

@interface CluesViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) ClueSheet *clues;

- (id) init;



@end
