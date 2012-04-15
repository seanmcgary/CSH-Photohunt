//
//  AppPhotoUploadViewController.m
//  photohunt
//
//  Created by Sean McGary on 4/15/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "AppPhotoUploadViewController.h"

@interface AppPhotoUploadViewController ()

@end

@implementation AppPhotoUploadViewController

@synthesize photos;
@synthesize photosNotUploaded;
@synthesize uploadCells;

- (id) init
{
    self = [super init];
    
    if(self){
        self.title = @"Uploads";
        self.uploadCells = [[NSMutableArray alloc] init];
        self.photos = [[NSMutableArray alloc] initWithArray:[AppHelper getSavedPhotos]];
        
        self.photosNotUploaded = [[NSMutableArray alloc] init];
        
        // create a list of photos not yet uploaded
        for(NSMutableDictionary *photo in self.photos)
        {
            if([[photo objectForKey:@"hasBeenUploaded"] integerValue] == 0)
            {
                
                PhotoUploadCell *cell = [[PhotoUploadCell alloc] initWithPhotoData:photo];
                
                cell.textLabel.text = [photo objectForKey:@"photoName"];
                
                [self.uploadCells addObject:cell];
            }
        }
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.uploadCells count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    //NSMutableDictionary *photo = [[NSMutableDictionary alloc] initWithDictionary:[self.photosNotUploaded objectAtIndex:indexPath.row]];
    
    
    
    
    return [self.uploadCells objectAtIndex:indexPath.row];
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
    PhotoUploadCell *cell = (PhotoUploadCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    if([[[cell photoData] objectForKey:@"hasBeenUploaded"] integerValue] == 0)
    {
        // upload
        [cell setUpload:YES];
        
        NSString *teamToken = [AppHelper getTeamToken];
        
        NSMutableDictionary *jsonPayload = [[NSMutableDictionary alloc] init];
        
        [jsonPayload setObject:[cell.photoData objectForKey:@"notes"] forKey:@"notes"];
        
        BOOL judge = [[cell.photoData objectForKey:@"judge"] boolValue];
        
        [jsonPayload setObject:[NSNumber numberWithBool:judge] forKey:@"judge"];
        
        [jsonPayload setObject:[[NSArray alloc] initWithArray:[cell.photoData objectForKey:@"clues"]] forKey:@"clues"];
        
        NSError *jsonParseError;
        NSData* jsonData = [NSJSONSerialization 
                            dataWithJSONObject:jsonPayload 
                            options:NSJSONWritingPrettyPrinted 
                            error:&jsonParseError];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://photohunt.csh.rit.edu/api/photos/new?token=%@", teamToken]];
        
        __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        NSMutableDictionary *requestHeaders = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"application/json", @"Accept", nil];
        
        // TODO - make this actually check the cert
        [request setValidatesSecureCertificate:NO];
        [request setRequestHeaders: requestHeaders];
        [request setRequestMethod:@"POST"];
        [request addRequestHeader:@"Content-Type" value:@"application/json"];
        
        // set POST values
        
        [request setPostValue:jsonString forKey:@"json"];
        
        [request setFile:[cell.photoData objectForKey:@"photoPath"] withFileName:[cell.photoData objectForKey:@"photoName"] andContentType:@"image/jpeg" forKey:@"photo"];
        [request setUploadProgressDelegate:cell.uploadProgress];
        [request setCompletionBlock:^{
            NSData *respData = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *jsonErr;
            
            NSMutableDictionary *jsonResp = [NSJSONSerialization JSONObjectWithData:respData options:NSJSONReadingMutableContainers error:&jsonErr];
            
            NSLog(@"upload response: %@", jsonResp);
            
            if([[jsonResp objectForKey:@"code"] integerValue] == 0){
                // mark the photo as uploaded
            
                
                [AppHelper markPhotoAsUploaded:[cell.photoData objectForKey:@"photoName"]];
                
                [AppHelper setPhotoPhotoId:[jsonResp objectForKey:@"data"] photoName:[cell.photoData objectForKey:@"photoName"]];
                
                [cell.photoData setObject:[jsonResp objectForKey:@"data"] forKey:@"photoId"];
                
                
                
                [self.uploadCells removeObject:cell];
                
                [self.tableView reloadData];
            } else {
                // some error
                NSLog(@"Upload error");
            }
            
        }];
        
        [request setFailedBlock:^{
            NSError *err = [request error];
            
            NSLog(@"Error: %@", [err localizedDescription]);
            
        }];
        
        [request startAsynchronous];
        
        [self.tableView reloadData];
        
    }
    
    
}

@end
