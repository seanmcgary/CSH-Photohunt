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
@synthesize photoData;
@synthesize selectionStatus;
@synthesize noBonusSelected;
@synthesize clueIsSelected;


- (id) initWithClueData: (NSDictionary *) clue: (BOOL) showBonus {
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if(self){
        self.clueData = [[NSDictionary alloc] initWithDictionary:clue];
        self.showBonus = showBonus;
        
        self.title = @"Clue Info";
        
        [self parseSections:clue];
        
    }
    
    return self;
}

- (id) initWithClueData: (NSDictionary *) clue withPhotoData: (NSMutableDictionary *) photoData
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if(self){
        self.clueData = [[NSDictionary alloc] initWithDictionary:clue];
        self.showBonus = YES;
        self.title = @"Clue Info";
        self.photoData = [[NSMutableDictionary alloc] initWithDictionary:photoData];
        
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] 
                                      initWithTitle:@"Save"
                                      style:UIBarButtonItemStyleBordered
                                      target:self
                                      action:@selector(saveClue:)];
        
        self.navigationItem.rightBarButtonItem = barButton;
        
        // create a dictionary to keep track of selected items
        self.selectionStatus = [[NSMutableDictionary alloc] init];        
        
        // parse clues into the table
        [self parseSections:clue];
        
        NSMutableArray *storedClues = [[NSMutableArray alloc] initWithArray:[self.photoData objectForKey:@"clues"]];
        
        NSMutableDictionary *storedClue;
        
        NSLog(@"StoredClue: %@", storedClues);
        NSLog(@"Clue data: %@", clueData);
        
        for(NSMutableDictionary *c in storedClues)
        {
            NSLog(@"clue: %@", c);
            if([[c objectForKey:@"id"] integerValue] == [[clueData objectForKey:@"id"] integerValue])
            {
                NSLog(@"found clue");
                storedClue = [[NSMutableDictionary alloc] initWithDictionary:c];
            }
        }
        
        NSLog(@"Stored clue: %@", storedClue);
        
        if(storedClue){
            NSLog(@"clue is selected");
            self.clueIsSelected = YES;
            
            if([[storedClue objectForKey:@"bonuses"] count] > 0){
                self.noBonusSelected = NO; 
            } else {
                self.noBonusSelected = YES;
            }
            
            
        } else {
            NSLog(@"clue is not stored");
            self.clueIsSelected = NO;
        }
        
        
        
        // put the bonuses in the selectionStatus list
        for(NSDictionary *bonus in [clueData objectForKey:@"bonuses"])
        {
            
            if(storedClue){
                
                BOOL found = NO;
                
                for(NSNumber *bonusId in [storedClue objectForKey:@"bonuses"])
                {
                    if([bonusId integerValue] == [[bonus objectForKey:@"id"] integerValue])
                    {
                        found = YES;
                        [selectionStatus setObject:[NSNumber numberWithInt:1] forKey:[bonus objectForKey:@"id"]];
                        
                    }
                }
                
                if(found == NO){
                    [selectionStatus setObject:[NSNumber numberWithInt:0] forKey:[bonus objectForKey:@"id"]];
                }
                
            } else {
            
                [selectionStatus setObject:[NSNumber numberWithInt:0] forKey:[bonus objectForKey:@"id"]];
            }
        }
        
        // add a section to select "No bonus"
        [sections addObject:[[NSArray alloc] initWithObjects:@"No Bonus", nil]];
        
        // put the bonuses in a section
        NSArray *bonuses = [[NSArray alloc] initWithArray:[clue objectForKey:@"bonuses"]];
        [sections addObject:bonuses];
    }
    
    return self;
}

- (void) parseSections: (NSDictionary *) clue
{
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
    //NSLog(@"Section: %u", section);
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //NSLog(@"indexpath: %u", indexPath.section);
    
    if(indexPath.section == 0){
    
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"foobar"];
    
        cell.textLabel.text = [[[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"category"];
    
        cell.detailTextLabel.text = [[[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"value"];
        
        cell.userInteractionEnabled = NO;
    
        return cell;
    } else if (indexPath.section == 1){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"nobonus"];
        
        cell.textLabel.text = [[sections objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        
        if(self.noBonusSelected == YES){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
        return cell;
        
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"nobonus"];
        
        cell.textLabel.text = [[[sections objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] objectForKey:@"description"];
        
        NSNumber *selected = [self.selectionStatus objectForKey:[[[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"id"]];
        
        if([selected integerValue] == 1){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
        return cell;
    }
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
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    
    if(indexPath.section == 1){
        NSLog(@"Set to no bonus");
        
        for(NSDictionary *b in [clueData objectForKey:@"bonuses"])
        {
            [selectionStatus setObject:[NSNumber numberWithInt:0] forKey:[b objectForKey:@"id"]];
        }
        
        if(self.noBonusSelected == YES){
            self.noBonusSelected = NO;
            self.clueIsSelected = NO;
        } else {
            self.noBonusSelected = YES;
            self.clueIsSelected = YES;
        }
    
    } else if(indexPath.section == 2){
        self.noBonusSelected = NO;
        self.clueIsSelected = YES;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        // get the status
        NSNumber *status = [self.selectionStatus objectForKey:[[[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"id"]];
        
        NSNumber *statusToSet;
        
        if([status integerValue] == 0)
        {
            statusToSet = [[NSNumber alloc] initWithInt:1];
        }
        else 
        {
            statusToSet = [[NSNumber alloc] initWithInt:0];
        }
        
        [self.selectionStatus setObject: statusToSet forKey:[[[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"id"]];
    }
    
    [self.tableView reloadData];  
    
}

-(IBAction)saveClue:(id)sender 
{
    NSLog(@"Saving clue");
    NSLog(@"Selections: %@", selectionStatus);
    
    NSMutableDictionary *clueObject = [[NSMutableDictionary alloc] init];
    
    if(self.noBonusSelected && self.clueIsSelected){
        // save with no clues
        NSLog(@"no bonuses, but clue is selected");
        [clueObject setObject:[self.clueData objectForKey:@"id"] forKey:@"id"];
        [clueObject setObject:[[NSArray alloc] init] forKey:@"bonuses"];
        
        [AppHelper setClueForPhoto:clueObject forPhotoName:[photoData objectForKey:@"photoName"]];
        
    } else if(self.clueIsSelected){
        // bonuses are selected
        NSLog(@"Bonuses selected and clue is selected");
        [clueObject setObject:[self.clueData objectForKey:@"id"] forKey:@"id"];
        
        NSMutableArray *bonuses = [[NSMutableArray alloc] init];
        
        for(NSDictionary *bonus in [clueData objectForKey:@"bonuses"])
        {
            NSNumber *state = [selectionStatus objectForKey:[bonus objectForKey:@"id"]];
            
            if([state integerValue] == 1){
                [bonuses addObject:[bonus objectForKey:@"id"]];
            }
        }
        
        [clueObject setObject:bonuses forKey:@"bonuses"];
        
        //NSLog(@"Bonuses selected: %@", clueObject);
        [AppHelper setClueForPhoto:clueObject forPhotoName:[photoData objectForKey:@"photoName"]];
        
        
    } else {
        // no clue and no bonus
        NSLog(@"Clue is not selected at all");
        
        [AppHelper removeClueForPhoto:clueData forPhotoName:[self.photoData objectForKey:@"photoName"]];
        
       
    }
    
    self.photoData = [[NSMutableDictionary alloc] initWithDictionary:[AppHelper getPhotoDataForPhotoName:[self.photoData objectForKey:@"photoName"]]];
    //NSLog(@"Photodata:\n %@", self.photoData);
}

@end
