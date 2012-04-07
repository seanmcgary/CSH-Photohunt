//
//  AppHomeNavigationController.m
//  Photohunt
//
//  Created by Sean McGary on 4/7/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "AppHomeNavigationController.h"

@interface AppHomeNavigationController ()

@end

@implementation AppHomeNavigationController

@synthesize appStartView;

- (id) init {
    self = [super init];
    
    if(self){
        self.tabBarItem.title = @"Home";
        self.tabBarItem.image = [UIImage imageNamed:@"home.png"];
        
        appStartView = [[AppStartViewController alloc] init];
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
    
    [self pushViewController:appStartView animated:NO];
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
