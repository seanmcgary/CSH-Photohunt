//
//  AppHomeNavigationController.h
//  Photohunt
//
//  Created by Sean McGary on 4/7/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppStartViewController.h"

@interface AppHomeNavigationController : UINavigationController

@property (strong, nonatomic) AppStartViewController *appStartView;

- (id) init;

@end
