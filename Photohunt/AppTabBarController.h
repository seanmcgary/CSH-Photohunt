//
//  AppTabBarController.h
//  Photohunt
//
//  Created by Sean McGary on 3/24/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CameraNavigationController.h"
#import "GalleryNavigationController.h"
#import "AppStartViewController.h"

@interface AppTabBarController : UITabBarController

- (id) init;

@property (strong, nonatomic) CameraNavigationController *cameraNavController;

@property (strong, nonatomic) GalleryNavigationController *galleryNavController;

@property (strong, nonatomic) AppStartViewController *appStartView;

@end
