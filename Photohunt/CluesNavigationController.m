
//
//  CluesNavigationController.m
//  Photohunt
//
//  Created by Sean McGary on 3/25/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "CluesNavigationController.h"

@interface CluesNavigationController ()

@end

@implementation CluesNavigationController

@synthesize cluesView;

- (id) init
{
    self = [super init];
    
    if(self){
        
        cluesView = [[CluesViewController alloc] init];
        
        self.tabBarItem.title = @"Clues";
        self.tabBarItem.image = [UIImage imageNamed:@"clues2.png"];
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
    
    [self pushViewController:cluesView animated:NO];
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
