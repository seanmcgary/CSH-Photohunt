//
//  AppPhotoUploadViewController.h
//  photohunt
//
//  Created by Sean McGary on 4/15/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppHelper.h"
#import "PhotoUploadCell.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface AppPhotoUploadViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *photos;
@property (strong, nonatomic) NSMutableArray *photosNotUploaded;

@property (strong, nonatomic) NSMutableArray *uploadCells;

- (id) init;

@end
