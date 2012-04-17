//
//  GalleryCollectionViewController.h
//  Photohunt
//
//  Created by Sean McGary on 4/12/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "SSCollectionViewController.h"
#import "GalleryPhotoViewItem.h"
#import "EditPhotoViewController.h"

@interface GalleryCollectionViewController : SSCollectionViewController

@property (strong, nonatomic) NSMutableArray *photos;

@property (strong, nonatomic) NSMutableDictionary *loadedPhotoItems;

- (id) init;

@end
