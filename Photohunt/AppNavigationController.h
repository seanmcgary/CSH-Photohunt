//
//  AppNavigationController.h
//  Photohunt
//
//  Created by Sean McGary on 3/24/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraNavigationController.h"
#import "GalleryNavigationController.h"
#import "AppStartViewController.h"

@interface AppNavigationController : UINavigationController

@property (strong, nonatomic) UIToolbar *navToolbar;

@property (strong, nonatomic) CameraNavigationController *cameraNavController;

@property (strong, nonatomic) GalleryNavigationController *galleryNavController;

@property (strong, nonatomic) AppStartViewController *appStartView;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *cameraViewButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *galleryViewButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *otherbutton1;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *otherbutton2;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *otherbutton3;

- (id) init;

- (IBAction)pushCameraView:(id)sender;
- (IBAction)pushGalleryView:(id)sender;

@end
