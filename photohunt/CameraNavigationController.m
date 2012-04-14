//
//  CameraNavigationController.m
//  Photohunt
//
//  Created by Sean McGary on 3/24/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "CameraNavigationController.h"

@interface CameraNavigationController ()

@end

@implementation CameraNavigationController

@synthesize cameraView;

- (id) init
{
    self = [super init];
    
    if(self){
        cameraView = [[CameraViewController alloc] init];
        self.tabBarItem.title = @"Camera";
        self.tabBarItem.image = [UIImage imageNamed:@"camera2.png"];
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
    [self pushViewController:cameraView animated:YES];
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
