//
//  CluesNavigationController.h
//  Photohunt
//
//  Created by Sean McGary on 3/25/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CluesViewController.h"

@interface CluesNavigationController : UINavigationController

@property (strong, nonatomic) CluesViewController *cluesView;

- (id) init;

@end
