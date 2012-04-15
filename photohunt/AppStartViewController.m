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
@synthesize requiresLogin;

- (id) init
{
    self = [super init];
    
    if(self){
        self.view.backgroundColor = [UIColor blueColor];
        
    }
    
    return self;
}

- (void) viewWillAppear:(BOOL)animated 
{
    NSMutableDictionary *gameData = [AppHelper getGameData];
    NSArray *settings = [[NSArray alloc] initWithObjects:@"Settings", nil];
    NSArray *downloads = [[NSArray alloc] initWithObjects:@"Photo Upload Status", nil];
    
    if(gameData == nil){
        requiresLogin = YES;
        sections = [[NSArray alloc] initWithObjects:settings, nil];
    } else {
        requiresLogin = NO;
        NSLog(@"Game data: %@", gameData);
        cells = [[NSArray alloc] initWithObjects: 
                 [[AppCellData alloc] initWithData:@"Team Name" :[gameData objectForKey:@"team"]],
                 [[AppCellData alloc] initWithData:@"Photos Taken" :[NSString stringWithFormat:@"%u/%u", [[gameData objectForKey:@"photosTaken"] integerValue], [[gameData objectForKey:@"maxPhotos"] integerValue]]],
                 [[AppCellData alloc] initWithData:@"Photos Submitted" :[NSString stringWithFormat:@"%u/%u", [[gameData objectForKey:@"photosJudged"] integerValue], [[gameData objectForKey:@"maxJudgedPhotos"] integerValue]]],
                 [[AppCellData alloc] initWithData:@"Potential Points" :[NSString stringWithFormat:@"%u", [[gameData objectForKey:@"pointsSubmitted"] integerValue]]],
                 [[AppCellData alloc] initWithData:@"Time Left" :@"4:12"],
                 nil];
        
        sections = [[NSArray alloc] initWithObjects:cells, settings, downloads, nil];
    }
    
    tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStyleGrouped];
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView reloadData];
    
    self.view = tableView;
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
    return [sections count];
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
    
    if(indexPath.section == 0 && requiresLogin == NO){
    
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
        
    } else if (indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        }
        
        cell.textLabel.text = @"Settings";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        }
        
        cell.textLabel.text = @"Photo Upload Status";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 1){
        AppSettingsViewController *settings = [[AppSettingsViewController alloc] init];
    
        [self.navigationController pushViewController:settings animated:YES];
    } else {
        AppPhotoUploadViewController *uploads = [[AppPhotoUploadViewController   alloc] init];
        
        [self.navigationController pushViewController:uploads animated:YES];
    }
}

@end
