//
//  GalleryNavigationController.h
//  Photohunt
//
//  Created by Sean McGary on 4/12/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryCollectionViewController.h"

@interface GalleryNavigationController : UINavigationController

@property (strong, nonatomic) GalleryCollectionViewController *collectionView;

- (id) init;

@end
