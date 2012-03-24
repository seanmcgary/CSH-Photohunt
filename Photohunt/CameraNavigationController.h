//
//  CameraNavigationController.h
//  Photohunt
//
//  Created by Sean McGary on 3/24/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraViewController.h"

@interface CameraNavigationController : UINavigationController

@property (strong, nonatomic) CameraViewController *cameraView;

- (id) init;

@end
