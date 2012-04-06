//
//  CluesViewController.m
//  Photohunt
//
//  Created by Sean McGary on 4/5/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "CluesViewController.h"

@interface CluesViewController ()

@end

@implementation CluesViewController

@synthesize items;
@synthesize clues;

- (id) init {
    self = [super init];
    
    if(self){
        self.title = @"Tags";
        items = [[NSMutableArray alloc] init];
        
        [items addObject:@"All Clues"];
        
        clues = [[ClueSheet alloc] init];
        
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    items = [[NSMutableArray alloc] initWithObjects:
                                    @"View All",
             nil];
    
    NSURL *url = [NSURL URLWithString:@"http://waffles.csh.rit.edu/api/clues"];
    
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSMutableDictionary *requestHeaders = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"application/json", @"Accept", nil];
    
    [request setRequestHeaders: requestHeaders];
    [request setCompletionBlock:^{
        NSData *respData = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *jsonErr;
        
        NSMutableDictionary *jsonResp = [NSJSONSerialization JSONObjectWithData:respData options:NSJSONReadingMutableContainers error:&jsonErr];
        
        [clues parseClueJSON:jsonResp];
        
        [self.tableView reloadData];
        
        
    }];
    
    [request setFailedBlock:^{
        NSError *err = [request error];
        
        NSLog(@"Error: %@", [err localizedDescription]);
    }];
    
    [request startAsynchronous];
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
    //return [items count];
    NSLog(@"Num clues: %u", [clues numClues]);
    return [clues numTags];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"Creating cell");
    //static NSString *CellIdentifier = @"Cell";
    
    /*UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    }*/
    
    TagCell *cell = [[TagCell alloc] init];
    
    NSString *desc = [clues.tagList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = desc;
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.tagDesc = desc;
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
    TagCell *cell = (TagCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"Index path: %@", cell.textLabel.text);
    
    NSString *tag = cell.tagDesc;
    
    // get the tag with its associated clues
    NSArray *tagClues = [clues getCluesForTag:tag];

    
    CluesTableViewController *cluesView = [[CluesTableViewController alloc] initWithClues:tagClues];
    
    [self.navigationController pushViewController:cluesView animated:YES];
    
}

@end
