//
//  GalleryViewController.m
//  Photohunt
//
//  Created by Sean McGary on 3/24/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "GalleryViewController.h"

@interface GalleryViewController ()

@end

@implementation GalleryViewController

- (id) init 
{
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
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"Gallery view controller";
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
