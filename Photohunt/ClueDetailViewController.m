//
//  ClueDetailViewController.m
//  Photohunt
//
//  Created by Sean McGary on 4/6/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "ClueDetailViewController.h"

@interface ClueDetailViewController ()

@end

@implementation ClueDetailViewController

@synthesize clueData;
@synthesize sections;
@synthesize showBonus;

- (id) initWithClueData: (NSDictionary *) clue: (BOOL) showBonus {
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if(self){
        self.clueData = [[NSDictionary alloc] initWithDictionary:clue];
        self.showBonus = showBonus;
        
        self.title = @"Clue Info";
        
        sections = [[NSMutableArray alloc] init];
        
        
        
        NSMutableArray *clueDataSection = [[NSMutableArray alloc] init];
        
        [clueDataSection addObject:
         [[NSDictionary alloc] initWithObjectsAndKeys:
            @"Clue Description", @"category",
          [clue objectForKey:@"description"], @"value", nil]];
        
        [clueDataSection addObject:
         [[NSDictionary alloc] initWithObjectsAndKeys:
          @"Points", @"category",
          [[clue objectForKey:@"points"] stringValue], @"value", nil]];
        
        
         
        NSArray *tagList = [[NSArray alloc] initWithArray:[clue objectForKey:@"tags"]];
        
        [clueDataSection addObject:
         [[NSDictionary alloc] initWithObjectsAndKeys:
          @"Tags", @"category",
          [tagList componentsJoinedByString:@", "], @"value", nil]];
        
        if([[clue objectForKey:@"points"] isKindOfClass:[NSNumber class]]){
            NSLog(@"Yup, its a number");
        }
        
        
        [sections addObject:clueDataSection];
        
        
        
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
    
    UILabel *clueLabel = [[UILabel alloc] init];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.sections objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{
    // The header for the section is the region name -- get this from the region at the section index.
    NSLog(@"Section: %u", section);
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"indexpath: %@", indexPath.section);
    
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"foobar"];
    
    cell.textLabel.text = [[[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"category"];
    
    cell.detailTextLabel.text = [[[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"value"];
    
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
    /*ClueCell *cell = (ClueCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"Cell: %@", cell.clueInfo);
    
    ClueDetailViewController *details = [[ClueDetailViewController alloc] initWithClueData:cell.clueInfo];
    
    [self.navigationController pushViewController:details animated:YES];
     */
    
}

@end
