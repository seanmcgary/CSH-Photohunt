//
//  AppTabBarController.h
//  Photohunt
//
//  Created by Sean McGary on 3/24/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CameraNavigationController.h"
#import "AppStartViewController.h"
#import "CluesNavigationController.h"
#import "GalleryViewController.h";

@interface AppTabBarController : UITabBarController

- (id) init;

@property (strong, nonatomic) CameraNavigationController *cameraNavController;
@property (strong, nonatomic) CluesNavigationController *cluesNavController; 
@property (strong, nonatomic) GalleryViewController *galleryView;

@property (strong, nonatomic) AppStartViewController *appStartView;

@end
