//
//  CluesTableViewController.m
//  Photohunt
//
//  Created by Sean McGary on 4/6/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "CluesTableViewController.h"

@interface CluesTableViewController ()

@end

@implementation CluesTableViewController

@synthesize clueList;
@synthesize photoData;
@synthesize isEditingClues;

- (id) initWithClues: (NSArray *) clueList {
    self = [super init];
    
    if(self){
        self.title = @"Clues";
        //NSLog(@"ClueList: %@", clueList);
        self.clueList = [[NSArray alloc] initWithArray:clueList];
        self.isEditingClues = NO;
    }
    
    return self;
}

- (id) initWithCluesForEditing: (NSArray *) clueList withPhotoData: (NSMutableDictionary *)photoData
{
    self = [super init];
    
    if(self){
        self.title = @"Clues";
        //NSLog(@"ClueList: %@", clueList);
        self.clueList = [[NSArray alloc] initWithArray:clueList];
        
        self.isEditingClues = YES;
        self.photoData = [[NSMutableDictionary alloc] initWithDictionary:photoData];
    }
    
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(self.isEditingClues){
        self.photoData = [[NSMutableDictionary alloc] initWithDictionary:[AppHelper getPhotoDataForPhotoName:[self.photoData objectForKey:@"photoName"]]];
        
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.clueList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *clue = [self.clueList objectAtIndex:indexPath.row];
    ClueCell *cell;
    
    if(self.isEditingClues){
        cell = [[ClueCell alloc] initWithClueInfo:clue andPhotoData:self.photoData];
        
        NSMutableArray *selectedCluesList = [[NSMutableArray alloc] initWithArray:[photoData objectForKey:@"clues"]];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        for(NSMutableDictionary *c in selectedCluesList)
        {
            if([[c objectForKey:@"id"] integerValue] == [[clue objectForKey:@"id"] integerValue])
            {
                
                cell.contentView.backgroundColor = [UIColor colorWithRed:0 green:1.0f blue:0 alpha:0.1f];
            }
        }
        
    } else {
        cell = [[ClueCell alloc] initWithClueInfo:clue];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    
    cell.textLabel.text = [clue objectForKey:@"description"];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClueCell *cell = (ClueCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    ClueDetailViewController *details;
    if(self.isEditingClues){
        
        details = [[ClueDetailViewController alloc] initWithClueData:cell.clueInfo withPhotoData:photoData];
        
    } else {
        details = [[ClueDetailViewController alloc] initWithClueData:cell.clueInfo: NO];
    }
    
    [self.navigationController pushViewController:details animated:YES];
    
    
}

- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Button tapped");
}

@end
