//
//  AppStartViewController.h
//  Photohunt
//
//  Created by Sean McGary on 3/24/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppCell.h"
#import "AppCellData.h"
#import "AppSettingsViewController.h"

@interface AppStartViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *cells;
@property (strong, nonatomic) NSArray *sections;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIToolbar *toolbar;

- (id) init;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
