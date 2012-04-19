//
//  AppTabBarController.m
//  Photohunt
//
//  Created by Sean McGary on 3/24/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "AppTabBarController.h"

@interface AppTabBarController ()

@end

@implementation AppTabBarController

@synthesize cameraView,
            appHomeNavController,
            cluesNavController,
            galleryNav;

- (id) init
{
    self = [super init];
    
    if(self){
        cameraView = [[CameraViewController alloc] init];
        cluesNavController = [[CluesNavigationController alloc] init];
        appHomeNavController = [[AppHomeNavigationController alloc] init];
        
        galleryNav = [[GalleryNavigationController alloc] init];
        
        
        
        self.viewControllers = [[NSArray alloc] initWithObjects:
                                                appHomeNavController,
                                                cameraView, 
                                                galleryNav, 
                                                cluesNavController,
                                nil];
    }
    
    return self;
}

- (void)switchToGallery
{
    [self setSelectedViewController:galleryNav];
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
