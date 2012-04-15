//
//  GalleryNavigationController.m
//  Photohunt
//
//  Created by Sean McGary on 4/12/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "GalleryNavigationController.h"

@interface GalleryNavigationController ()

@end

@implementation GalleryNavigationController

@synthesize collectionView;

- (id) init 
{
    self = [super init];
    
    if(self){
        self.tabBarItem.title = @"Gallery";
        self.tabBarItem.image = [UIImage imageNamed:@"gallery.png"];
        [self setNavigationBarHidden:YES];
        self.collectionView = [[GalleryCollectionViewController alloc] init];
        
        //self.toolbarHidden = YES;
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
    
    [self pushViewController:self.collectionView animated:NO];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
