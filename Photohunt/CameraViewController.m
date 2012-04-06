//
//  CameraViewController.m
//  Photohunt
//
//  Created by Sean McGary on 3/24/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

@synthesize fakeCamera;

- (id) init 
{
    
    self = [super init];
    
    if(self){
        self.view.backgroundColor = [UIColor whiteColor];
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
	// Do any additional setup after loading the view
    
    fakeCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [fakeCamera setBackgroundImage:[UIImage imageNamed:@"test_photo.JPG"] forState:UIControlStateNormal];
    
    fakeCamera.frame = CGRectMake(10, 10, self.view.frame.size.width - 20, (self.view.frame.size.height - 150));
    
    
    [fakeCamera addTarget:self action:@selector(takeFakePicture:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:fakeCamera];
    
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

- (IBAction)takeFakePicture:(id)sender
{
    NSLog(@"taking fake picture");
    
}

@end
