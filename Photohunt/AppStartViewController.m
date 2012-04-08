//
//  AppStartViewController.m
//  Photohunt
//
//  Created by Sean McGary on 3/24/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "AppStartViewController.h"

@interface AppStartViewController ()

@end

@implementation AppStartViewController

@synthesize sections;
@synthesize cells;
@synthesize tableView;
@synthesize toolbar;

- (id) init
{
    self = [super init];
    
    if(self){
        self.view.backgroundColor = [UIColor blueColor];
        
        cells = [[NSArray alloc] initWithObjects: 
                 [[AppCellData alloc] initWithData:@"Team Name" :@"Team Faggot"],
                 [[AppCellData alloc] initWithData:@"Photos Taken" :@"6/30"],
                 [[AppCellData alloc] initWithData:@"Photos Submitted" :@"3/20"],
                 [[AppCellData alloc] initWithData:@"Potential Points" :@"42"],
                 [[AppCellData alloc] initWithData:@"Time Left" :@"4:12"],
                 nil];
        
        NSArray *settings = [[NSArray alloc] initWithObjects:@"Settings", nil];
        
        sections = [[NSArray alloc] initWithObjects:cells, settings, nil];
        
        tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStyleGrouped];
        
        tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView reloadData];
        
        self.view = tableView;
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
    /*toolbar = [[UIToolbar alloc] init];
    
    toolbar.barStyle = UIBarStyleDefault;
    [toolbar sizeToFit];
    toolbar.frame = CGRectMake(0, 410, 320, 50);
    
    [self.tableView addSubview:toolbar];*/
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    // Number of rows is the number of time zones in the region for the specified section.
    
    NSArray *sec = [sections objectAtIndex:section];
    
    return [sec count];
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{
    // The header for the section is the region name -- get this from the region at the section index.
    
    return @"";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
    
    if(indexPath.section == 0){
    
        AppCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
        if (cell == nil) {
            cell = [[AppCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                  reuseIdentifier:MyIdentifier];
        }
    
        NSArray *section = [sections objectAtIndex:indexPath.section];
    
        AppCellData *item = [section objectAtIndex:indexPath.row];
    
        [cell setCellData:item.category:item.value];
        
        cell.userInteractionEnabled = NO;
    
        return cell;
        
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        }
        
        cell.textLabel.text = @"Settings";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppSettingsViewController *settings = [[AppSettingsViewController alloc] init];
    
    [self.navigationController pushViewController:settings animated:YES];
}

@end
