//
//  CameraViewController.h
//  Photohunt
//
//  Created by Sean McGary on 4/6/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import "NSMutableDictionary+ImageMetadata.h"

@interface CameraViewController : UIImagePickerController <UIImagePickerControllerDelegate, CLLocationManagerDelegate>

@property (strong, atomic) ALAssetsLibrary* library;

@property (nonatomic, retain) CLLocationManager *locMgr;

- (id) init;


@end
