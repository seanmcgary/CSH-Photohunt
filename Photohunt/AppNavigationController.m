//
//  AppNavigationController.m
//  Photohunt
//
//  Created by Sean McGary on 3/24/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "AppNavigationController.h"

@interface AppNavigationController ()

@end

@implementation AppNavigationController

@synthesize navToolbar;
@synthesize cameraNavController;
@synthesize galleryNavController;
@synthesize appStartView;
@synthesize cameraViewButton;
@synthesize galleryViewButton;
@synthesize otherbutton1;
@synthesize otherbutton2;
@synthesize otherbutton3;

- (id) init
{
    self = [super init];
    
    if(self){
        cameraNavController = [[CameraNavigationController alloc] init];
        galleryNavController = [[GalleryNavigationController alloc] init];
        appStartView = [[AppStartViewController alloc] init];
        
        [self pushViewController:appStartView animated:NO];
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
    
    
    
    
    
    navToolbar = [[UIToolbar alloc] init];
    
    navToolbar.frame = CGRectMake(0, 
                               self.view.frame.size.height - 44,
                               self.view.frame.size.width, 
                               44);
    
    
    
    /*UIBarButtonItem *button = [[UIBarButtonItem alloc] init];
    button.title = @"Other view";
    button.style = UIBarButtonItemStyleBordered;
    
    [button setAction:@selector(buttonClick:)];*/
    
    cameraViewButton = [[UIBarButtonItem alloc] init];
    cameraViewButton.title = @"Camera";
    cameraViewButton.style = UIBarStyleBlack;
    [cameraViewButton setAction:@selector(pushCameraView:)];
    
    galleryViewButton = [[UIBarButtonItem alloc] init];
    galleryViewButton.title = @"Gallery";
    galleryViewButton.style = UIBarStyleBlack;
    [galleryViewButton setAction:@selector(pushGalleryView:)];
    
    otherbutton1 = [[UIBarButtonItem alloc] init];
    otherbutton1.title = @"Gallery";
    otherbutton1.style = UIBarStyleBlack;
    [otherbutton1 setAction:@selector(pushGalleryView:)];
    
    otherbutton2 = [[UIBarButtonItem alloc] init];
    otherbutton2.title = @"Gallery";
    otherbutton2.style = UIBarStyleBlack;
    [otherbutton2 setAction:@selector(pushGalleryView:)];
    
    otherbutton3 = [[UIBarButtonItem alloc] init];
    otherbutton3.title = @"Gallery";
    otherbutton3.style = UIBarStyleBlack;
    [otherbutton3 setAction:@selector(pushGalleryView:)];
    
    
    [navToolbar setItems:[[NSArray alloc] 
                          initWithObjects:
                            cameraViewButton, 
                            galleryViewButton, 
                            otherbutton1,
                            otherbutton2,
                            otherbutton3,
                          nil]];
    
    navToolbar.barStyle = UIBarStyleBlack;
    
    [self.view addSubview:navToolbar];
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

- (IBAction)pushCameraView:(id)sender
{
    NSLog(@"Camera");
}

- (IBAction)pushGalleryView:(id)sender
{
    NSLog(@"Gallery");
}

@end
