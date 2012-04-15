//
//  PhotoUploadCell.h
//  photohunt
//
//  Created by Sean McGary on 4/15/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoUploadCell : UITableViewCell

@property (strong, nonatomic) NSMutableDictionary *photoData;
@property (readwrite, assign) BOOL isUploading;
@property (strong, nonatomic) UIProgressView *uploadProgress;

- (id) initWithPhotoData: (NSMutableDictionary *)photoData;

- (void) setUpload: (BOOL) uploading;

@end
