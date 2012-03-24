//
//  AppDelegate.h
//  Photohunt
//
//  Created by Sean McGary on 3/24/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppNavigationController.h"
#import "AppTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AppNavigationController *appNavController;
@property (strong, nonatomic) AppTabBarController *appTabBarController;


@end
