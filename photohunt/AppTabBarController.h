//
//  AppTabBarController.h
//  Photohunt
//
//  Created by Sean McGary on 3/24/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CameraNavigationController.h"
#import "CluesNavigationController.h"
#import "CameraViewController.h"
#import "AppHomeNavigationController.h"
#import "GalleryNavigationController.h"

@interface AppTabBarController : UITabBarController

- (id) init;

- (void)switchToGallery;

@property (strong, nonatomic) CameraViewController *cameraView;

@property (strong, nonatomic) CluesNavigationController *cluesNavController; 

@property (strong, nonatomic) AppHomeNavigationController *appHomeNavController;

@property (strong, nonatomic) GalleryNavigationController *galleryNav;

@end
