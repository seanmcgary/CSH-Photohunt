//
//  EditPhotoViewController.m
//  Photohunt
//
//  Created by Sean McGary on 4/8/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "EditPhotoViewController.h"

@interface EditPhotoViewController ()

@end

@implementation EditPhotoViewController

@synthesize photoWithMetaData;
@synthesize teamToken;
@synthesize scrollView;
@synthesize judgeLabel;
@synthesize judgeSwitch;
@synthesize notesField;
@synthesize notesLabel;
@synthesize imageView;
@synthesize inNotes;
@synthesize doneButton;
@synthesize uploadProgress;
@synthesize uploadLabel;
@synthesize selectCluesButton;


-(id) initWithPhoto: (NSMutableDictionary *)photoWithMetaData
{
    self = [super init];
    
    if(self){
        scrollView = [[UIScrollView alloc] init];
        scrollView.bounces = YES;
        self.tabBarController.tabBar.hidden = YES;
        self.photoWithMetaData = photoWithMetaData;
        self.title = @"Edit Photo";
        teamToken = [AppHelper getTeamToken];
        
        NSLog(@"token: %@", teamToken);
    }
    
    return self;
}

- (void) uploadPhoto
{
    NSLog(@"uploading...");
    // get the teamID
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://photohunt.csh.rit.edu/api/photos/new?token=%@", teamToken]];
    
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    NSMutableDictionary *requestHeaders = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"application/json", @"Accept", nil];
    
    // TODO - make this actually check the cert
    [request setValidatesSecureCertificate:NO];
    [request setRequestHeaders: requestHeaders];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    
    // set POST values
    [request setPostValue:@"{\"clues\":[], \"judge\":\"False\", \"notes\":\"\"}" forKey:@"json"];
    
    [request setFile:[photoWithMetaData objectForKey:@"photoPath"] withFileName:[photoWithMetaData objectForKey:@"photoName"] andContentType:@"image/jpeg" forKey:@"photo"];
    [request setUploadProgressDelegate:uploadProgress];
    [request setCompletionBlock:^{
        NSData *respData = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
        
        //NSLog(@"server response:\n%@", [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding]);
        NSError *jsonErr;
        
        NSMutableDictionary *jsonResp = [NSJSONSerialization JSONObjectWithData:respData options:NSJSONReadingMutableContainers error:&jsonErr];
        
        NSLog(@"upload response: %@", jsonResp);
        
        if([[jsonResp objectForKey:@"code"] integerValue] == 0){
            // mark the photo as uploaded
            
            [self.uploadLabel setText:@"Uploaded"];
            [self.uploadProgress setHidden:YES];
            
            [AppHelper markPhotoAsUploaded:[photoWithMetaData objectForKey:@"photoName"]];
            
            [AppHelper setPhotoPhotoId:[jsonResp objectForKey:@"data"] photoName:[photoWithMetaData objectForKey:@"photoName"]];
            
            [photoWithMetaData setObject:[jsonResp objectForKey:@"data"] forKey:@"photoId"];
        }
        
    }];
    
    [request setFailedBlock:^{
        NSError *err = [request error];
        
        NSLog(@"Error: %@", [err localizedDescription]);
    }];
    
    [request startAsynchronous];
     
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

    uploadLabel = [[UILabel alloc] init];
    
    if([[self.photoWithMetaData objectForKey:@"hasBeenUploaded"] integerValue] == 0)
    {
        
        self.uploadProgress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        
        self.uploadProgress.frame = CGRectMake(10, 210, (self.view.frame.size.width - 20), 31);
        
        [self.view addSubview:self.uploadProgress];
        
        [uploadLabel setText:@"Uploading..."];
        
        [self uploadPhoto];
        
    } 
    else 
    {
        [self.uploadLabel setText:@"Uploaded"];
    }
    

    //NSLog(@"Frame: %@", self.view.frame);
    scrollView.frame = self.view.frame;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 5000);
    [self.view addSubview:scrollView];
    

    UIImage *image = [photoWithMetaData objectForKey:@"image"];
    
    imageView = [[UIImageView alloc] init];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    imageView.frame = CGRectMake(10, 10, (self.view.frame.size.width - 20), 200);
    imageView.backgroundColor = [UIColor blackColor];
    
    //imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImage *newImage = [AppHelper imageWithImage:image scaledToSize:CGSizeMake((self.view.frame.size.width - 20), 200)];
    
    [imageView setImage:newImage];
    
    uploadLabel.frame = CGRectMake(10, 230, (self.view.frame.size.width - 20), 31);
    
    judgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 270, 100, 31)];
    
    judgeLabel.text = @"Judge?";
    
    judgeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(110, 270, 50, 31)];
    
    if([[photoWithMetaData objectForKey:@"judge"] integerValue] == 1)
    {
        judgeSwitch.on = YES;
    }
    
    
    notesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 310, 100, 31)];
    notesLabel.text = @"Photo Notes:";
    
    notesField = [[UITextField alloc] initWithFrame:CGRectMake(10, 342, (self.view.frame.size.width - 20), 31)];
    [notesField setBorderStyle:UITextBorderStyleRoundedRect];
    [notesField setReturnKeyType:UIReturnKeyDone];
    
    notesField.delegate = self;
    
    notesField.backgroundColor = [UIColor colorWithRed:.90f green:.90f blue:.90f alpha:1]; 
    
    [notesField setText:[photoWithMetaData objectForKey:@"notes"]];
    
    doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    doneButton.frame = CGRectMake(10, 383, 100, 31);
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    selectCluesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectCluesButton.frame = CGRectMake(10, 424, (self.view.frame.size.width - 20), 31);
    [selectCluesButton setTitle:@"Select Clues" forState:UIControlStateNormal];
    [selectCluesButton addTarget:self action:@selector(selectClues:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [scrollView addSubview:imageView];
    [scrollView addSubview:uploadLabel];
    [scrollView addSubview:judgeLabel];
    [scrollView addSubview:judgeSwitch];
    [scrollView addSubview:notesLabel];
    [scrollView addSubview:notesField];
    [scrollView addSubview:doneButton];
    [scrollView addSubview:selectCluesButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    NSLog(@"unloading edit photo view");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doneButtonPressed:(id)sender 
{
    // if judged == checked && photo is not marked as judged, mark it
    if(self.judgeSwitch.on == YES && [[photoWithMetaData objectForKey:@"judge"] integerValue] == 0)
    {
        [AppHelper markPhotoAsJudged:[photoWithMetaData objectForKey:@"photoName"]];
    }
    
    if(self.judgeSwitch.on == NO && [[photoWithMetaData objectForKey:@"judge"] integerValue] == 1)
    {
        [AppHelper unmarkPhotoAsJudged:[photoWithMetaData objectForKey:@"photoName"]];
    }
    
    // save the notes field
    [AppHelper setPhotoNotes:notesField.text forPhotoName:[photoWithMetaData objectForKey:@"photoName"]];
    
    // prep the json to send to the server
    NSMutableDictionary *jsonPayload = [[NSMutableDictionary alloc] init];
    
    [jsonPayload setObject:notesField.text forKey:@"notes"];
    [jsonPayload setObject:[NSNumber numberWithBool:self.judgeSwitch.on] forKey:@"judge"];
    [jsonPayload setObject:[[NSArray alloc] init] forKey:@"clues"];
    
    NSError *jsonParseError;
    NSData* jsonData = [NSJSONSerialization 
                        dataWithJSONObject:jsonPayload 
                        options:NSJSONWritingPrettyPrinted 
                        error:&jsonParseError];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"JSON data?\n %@", jsonString);
    NSString *photoId = [photoWithMetaData objectForKey:@"photoId"];
    NSLog(@"photoid: %@", photoId);
    
    NSString *urlString = [NSString stringWithFormat:@"https://photohunt.csh.rit.edu/api/photos/edit?id=%@&token=%@", [photoWithMetaData objectForKey:@"photoId"], teamToken];
    
    NSLog(@"urlString: %@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSMutableDictionary *requestHeaders = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"application/json", @"Accept", nil];
    
    // TODO - make this actually check the cert
    [request setValidatesSecureCertificate:NO];
    [request setRequestHeaders: requestHeaders];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:@"PUT"];
    
    [request appendPostData: jsonData];
    
    // set POST values
    [request setUploadProgressDelegate:uploadProgress];
    [request setCompletionBlock:^{
        NSData *respData = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"resp data: %@", respData);
        NSError *jsonErr;
        
        NSMutableDictionary *jsonResp = [NSJSONSerialization JSONObjectWithData:respData options:NSJSONReadingMutableContainers error:&jsonErr];
        
        NSLog(@"edit response: %@", jsonResp);
        
        // pop back to the camera
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    
    [request setFailedBlock:^{
        NSError *err = [request error];
        
        NSLog(@"Error: %@", [err localizedDescription]);
    }];
    
    [request startAsynchronous];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)selectClues:(id)sender
{
    NSMutableDictionary *clueSheet = [[NSMutableDictionary alloc] initWithDictionary: [AppHelper getClueSheet]];
    
    ClueTagViewController *tagTable = [[ClueTagViewController alloc] initWithPhotoClueData:[photoWithMetaData objectForKey:@"clues"] andPhotoData:photoWithMetaData];
    
    [self.navigationController pushViewController:tagTable animated:YES];
}

@end
