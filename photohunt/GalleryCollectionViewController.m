//
//  GalleryCollectionViewController.m
//  Photohunt
//
//  Created by Sean McGary on 4/12/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "GalleryCollectionViewController.h"

@interface GalleryCollectionViewController ()

@end

@implementation GalleryCollectionViewController

@synthesize photos;
@synthesize loadedPhotoItems;

- (id) init 
{
    
    self = [super init];
    
    if(self){
        self.view.backgroundColor = [UIColor blackColor];
        
        self.photos = [[NSMutableArray alloc] init];
        
        self.loadedPhotoItems = [[NSMutableDictionary alloc] init];
        
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController setToolbarHidden:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.

}

- (void) viewDidAppear:(BOOL)animated   
{
    [super viewDidAppear:animated];
    self.photos = [[NSMutableArray alloc] initWithArray:[AppHelper getSavedPhotos]];
    [self.collectionView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - SSCollectionViewDataSource

- (NSUInteger)numberOfSectionsInCollectionView:(SSCollectionView *)aCollectionView {
	return 1;
}


- (NSUInteger)collectionView:(SSCollectionView *)aCollectionView numberOfItemsInSection:(NSUInteger)section {
	return [photos count];
}


- (SSCollectionViewItem *)collectionView:(SSCollectionView *)aCollectionView itemForIndexPath:(NSIndexPath *)indexPath {
	static NSString *const itemIdentifier = @"itemIdentifier";
	
	/*SCImageCollectionViewItem *item = (SCImageCollectionViewItem *)[aCollectionView dequeueReusableItemWithIdentifier:itemIdentifier];
	if (item == nil) {
		item = [[[SCImageCollectionViewItem alloc] initWithReuseIdentifier:itemIdentifier] autorelease];
	}
	
	CGFloat size = 80.0f * [[UIScreen mainScreen] scale];
	NSInteger i = (50 * indexPath.section) + indexPath.row;
	item.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.gravatar.com/avatar/%i?s=%0.f&d=identicon", i, size]];
	*/
    
    
    
    NSDictionary *photoData = [[NSDictionary alloc] initWithDictionary:[photos objectAtIndex:indexPath.row]];
    
    NSString *photoPath = [photoData objectForKey:@"photoPath"];
    
    
    
    GalleryPhotoViewItem *item = [self.loadedPhotoItems objectForKey:photoPath];
    
    if(!item){
        item = [[GalleryPhotoViewItem alloc] initWithImagePath:photoPath];
        [self.loadedPhotoItems setObject:item forKey:photoPath];
    }   
    
	return item;
}


/*- (UIView *)collectionView:(SSCollectionView *)aCollectionView viewForHeaderInSection:(NSUInteger)section {
	SSLabel *header = [[SSLabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
	//header.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	return header;
}*/


#pragma mark - SSCollectionViewDelegate

- (CGSize)collectionView:(SSCollectionView *)aCollectionView itemSizeForSection:(NSUInteger)section {
	return CGSizeMake(80.0f, 80.0f);
}


- (void)collectionView:(SSCollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath 
{
	NSMutableDictionary *photo = [self.photos objectAtIndex:indexPath.row];
    
    //NSLog(@"photo: %@", photo);
    
    NSString *imagePath = [photo objectForKey:@"photoPath"];
    
    UIImage *photoImage = [[UIImage alloc] init];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath])
    {
        //File exists
        NSData *photo = [[NSData alloc] initWithContentsOfFile:imagePath];
        if (photo)
        {
            
            NSLog(@"Photo found");
            photoImage = [[UIImage alloc] initWithData:photo];
            
            
        }
    }
    else
    {
        NSLog(@"File does not exist");
    }
    
    [photo setObject:photoImage forKey:@"image"];
    
    
    EditPhotoViewController *editPhotoView = [[EditPhotoViewController alloc] initWithPhoto:photo];
    
    [self.navigationController pushViewController:editPhotoView animated:YES];
    
}


- (CGFloat)collectionView:(SSCollectionView *)aCollectionView heightForHeaderInSection:(NSUInteger)section {
	return 40.0f;
}

@end
