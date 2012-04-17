//
//  GalleryPhotoViewItem.m
//  Photohunt
//
//  Created by Sean McGary on 4/12/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "GalleryPhotoViewItem.h"

@implementation GalleryPhotoViewItem

@synthesize imagePath;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (id)initWithImagePath: (NSString *)imagePath {
	
    self = [super initWithStyle:SSCollectionViewItemStyleImage reuseIdentifier:@"photocell"];
    
    if(self){
        
        self.imagePath = imagePath;
        self.imageView.backgroundColor = [UIColor blackColor];
        
        UIImage *photoImage;
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath])
        {
            //File exists
            NSData *photo = [[NSData alloc] initWithContentsOfFile:imagePath];
            if (photo)
            {
                
                photoImage = [[UIImage alloc] initWithData:photo];
                
                UIImage *newImage = [AppHelper imageWithImage:photoImage scaledToSize:CGSizeMake(200, 200)];
                
                [self.imageView setImage:newImage];
                self.imageView.backgroundColor = [UIColor blackColor];
                
            }
        }
    }
    
    return self;
}


#pragma mark - Initializer

/*- (id)initWithReuseIdentifier:(NSString *)aReuseIdentifier {
	if ((self = [super initWithStyle:SSCollectionViewItemStyleImage reuseIdentifier:aReuseIdentifier])) {
		self.imageView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
	}
	return self;
}*/


- (void)prepareForReuse {
	[super prepareForReuse];
	self.imagePath = nil;
}


@end
