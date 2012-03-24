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

@synthesize cameraNavController,
            galleryNavController,
            appStartView;

- (id) init
{
    self = [super init];
    
    if(self){
        cameraNavController = [[CameraNavigationController alloc] init];
        galleryNavController = [[GalleryNavigationController alloc] init];
        appStartView = [[AppStartViewController alloc] init];
        
        self.viewControllers = [[NSArray alloc] initWithObjects:cameraNavController, galleryNavController, appStartView, nil];
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
