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
        
        //[self uploadPhoto];
        
        //NSLog(@"%@", self.photoWithMetaData);
    }
    
    return self;
}

- (void) uploadPhoto
{
    NSLog(@"uploading...");
    // get the teamID
    
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://photohunt.seanmcgary.com/api/photos/new?token=%@", teamToken]];
    
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    NSMutableDictionary *requestHeaders = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"application/json", @"Accept", nil];
    
    // TODO - make this actually check the cert
    //[request setValidatesSecureCertificate:NO];
    [request setRequestHeaders: requestHeaders];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    
    // set POST values
    [request setPostValue:@"{\"clues\":[], \"judge\":\"False\", \"notes\":\"\"}" forKey:@"json"];
    
    [request setFile:[photoWithMetaData objectForKey:@"photoPath"] withFileName:[photoWithMetaData objectForKey:@"photoName"] andContentType:@"image/jpeg" forKey:@"photo"];
    
    [request setCompletionBlock:^{
        NSData *respData = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"server response:\n%@", [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding]);
        NSError *jsonErr;
        
        NSMutableDictionary *jsonResp = [NSJSONSerialization JSONObjectWithData:respData options:NSJSONReadingMutableContainers error:&jsonErr];
        
        NSLog(@"upload response: %@", jsonResp);
        
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
    [self uploadPhoto];
    
    NSLog(@"Frame: %@", self.view.frame);
    scrollView.frame = self.view.frame;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 5000);
    [self.view addSubview:scrollView];
    

    
    UIImage *image = [photoWithMetaData objectForKey:@"image"];
    
    imageView = [[UIImageView alloc] init];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    imageView.frame = CGRectMake(10, 10, (self.view.frame.size.width - 20), 200);
    imageView.backgroundColor = [UIColor blackColor];
    
    //imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [imageView setImage:image];
    
    
    
    judgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, 100, 31)];
    
    judgeLabel.text = @"Judge?";
    
    judgeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(110, 220, 50, 31)];
    
    
    notesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 261, 100, 31)];
    notesLabel.text = @"Photo Notes:";
    
    notesField = [[UITextView alloc] initWithFrame:CGRectMake(10, 302, (self.view.frame.size.width - 20), 50)];
    notesField.editable = YES;
    
    [notesField setDelegate:self];
    [notesField setReturnKeyType:UIReturnKeyDone];
    [notesField setScrollEnabled:YES];
    
    notesField.backgroundColor = [UIColor colorWithRed:.90f green:.90f blue:.90f alpha:1]; 
    
    doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    doneButton.frame = CGRectMake(10, 362, 100, 31);
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addSubview:imageView];
    [scrollView addSubview:judgeLabel];
    [scrollView addSubview:judgeSwitch];
    [scrollView addSubview:notesLabel];
    [scrollView addSubview:notesField];
    [scrollView addSubview:doneButton];
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
    // save all the shit
    
    // pop back to the camera
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end