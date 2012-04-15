//
//  PhotoUploadCell.m
//  photohunt
//
//  Created by Sean McGary on 4/15/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "PhotoUploadCell.h"

@implementation PhotoUploadCell

@synthesize photoData;
@synthesize isUploading;
@synthesize uploadProgress;

- (id) initWithPhotoData: (NSMutableDictionary *)photoData
{
    self = [super init];
    
    if(self){
        self.photoData = [[NSMutableDictionary alloc] initWithDictionary:photoData];
        uploadProgress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        [self setUpload:NO];
    }
    
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setUpload: (BOOL) uploading
{
    self.isUploading = uploading;
    
    if(self.isUploading){
        // show spinner
        
        
        uploadProgress.frame = CGRectMake(0, 0, 50, 30);
        
        self.accessoryView = uploadProgress;
        
        
    } else {
        // show button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setImage:[UIImage imageNamed:@"upload.png"] forState:UIControlStateNormal];
        
        button.frame = CGRectMake(0, 0, 50, 30);
        
        self.accessoryView = button;
    }
}



@end
