//
//  GalleryNavigationController.h
//  Photohunt
//
//  Created by Sean McGary on 3/24/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryViewController.h"

@interface GalleryNavigationController : UINavigationController

@property (strong, nonatomic) GalleryViewController *galleryView;

- (id) init;

@end
