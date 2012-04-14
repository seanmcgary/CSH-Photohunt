//
//  CameraViewController.m
//  Photohunt
//
//  Created by Sean McGary on 4/6/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

@synthesize library;
@synthesize locMgr;

- (id) init
{
    self = [super init];
    
    if(self){
        self.tabBarItem.title = @"Camera";
        self.tabBarItem.image = [UIImage imageNamed:@"camera2.png"];
        
        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
        {
            self.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else 
        {
            self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        

        self.delegate = self;
        
        self.locMgr = [[CLLocationManager alloc] init];
        self.locMgr.delegate = self;
        
        
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    NSLog(@"unloaded camera");
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [locMgr startUpdatingLocation];
    
    //[self.tabBarController.tabBar setHidden:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"pickedImage");
    // Access the uncropped image from info dictionary
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    NSMutableDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:[info objectForKey:UIImagePickerControllerMediaMetadata]];
    
    [metadata setLocation:[locMgr location]];
    
    [locMgr stopUpdatingLocation];
    [locMgr stopMonitoringSignificantLocationChanges];
    
    NSMutableDictionary *photoContainer = [[NSMutableDictionary alloc] init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    time_t unixTime = (time_t) [[NSDate date] timeIntervalSince1970];
    
    NSString *photoName = [NSString stringWithFormat:@"%ld.jpg", unixTime];
    NSString *photoSavePath = [documentsDirectory stringByAppendingPathComponent:photoName];
    
    [photoContainer setObject:photoName forKey:@"photoName"];
    [photoContainer setObject:photoSavePath forKey:@"photoPath"];
    [photoContainer setObject:[NSNumber numberWithInt:0] forKey:@"hasBeenExported"];
    [photoContainer setObject:[NSNumber numberWithInt:0] forKey:@"hasBeenUploaded"];
    [photoContainer setObject:[[NSMutableArray alloc] init] forKey:@"clues"];
    [photoContainer setObject:[NSNumber numberWithInt:0] forKey:@"judge"];
    [photoContainer setObject:metadata forKey:@"metadata"];
    [photoContainer setObject:@"" forKey:@"photoId"];
    [photoContainer setObject:@"" forKey:@"notes"];
    
    // save the photo without the image embedded
    [AppHelper savePhotoData:photoContainer];
    
    // write the image to disk
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:photoSavePath atomically:YES];
    
    // increment number of photos taken
    [AppHelper incrementPhotoCount];
    
    // add the image to the container to pass it off to the edit view
    [photoContainer setObject:image forKey:@"image"];
    EditPhotoViewController *editPhoto = [[EditPhotoViewController alloc] initWithPhoto:photoContainer];
    
    [self pushViewController:editPhoto animated:YES];
}

@end
