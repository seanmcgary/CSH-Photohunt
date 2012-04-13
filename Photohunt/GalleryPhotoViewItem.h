//
//  GalleryPhotoViewItem.h
//  Photohunt
//
//  Created by Sean McGary on 4/12/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "SSCollectionViewItem.h"



@interface GalleryPhotoViewItem : SSCollectionViewItem

@property (strong, nonatomic) NSString *imagePath;

- (id)initWithImagePath: (NSString *)imagePath;

@end
