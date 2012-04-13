//
//  ClueTagViewController.h
//  Photohunt
//
//  Created by Sean McGary on 4/12/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ClueSheet.h"
#import "TagCell.h"
#import "CluesTableViewController.h"

@interface ClueTagViewController : UITableViewController


@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) ClueSheet *clues;

- (id) init;

@end
