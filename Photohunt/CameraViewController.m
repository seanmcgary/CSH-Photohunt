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
        self.library = [[ALAssetsLibrary alloc] init];
        
        self.locMgr = [[CLLocationManager alloc] init];
        self.locMgr.delegate = self;
        
        [locMgr startUpdatingLocation];
        
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"Picked image");
    // Access the uncropped image from info dictionary
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    NSMutableDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:[info objectForKey:UIImagePickerControllerMediaMetadata]];
    
    [metadata setLocation:[locMgr location]];
    
    NSLog(@"META: %@", metadata);
    
    [locMgr stopUpdatingLocation];
    
    // Save image
    //UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    NSUInteger groupTypes = ALAssetsGroupAll;
    
    [library writeImageToSavedPhotosAlbum:image.CGImage orientation:(ALAssetOrientation)image.imageOrientation 
                          completionBlock:^(NSURL* assetURL, NSError* error) {
                              if (error != NULL){
                                  // Show error message...
                              } else {  // No errors
                                  // Show message image successfully saved
                                  NSLog(@"Saved successfully");
                              }
                          }];

    [library enumerateGroupsWithTypes:groupTypes usingBlock:^(ALAssetsGroup *group, BOOL *stop ){
        if(group != nil) {
            //[assetGroups addObject:group];
            NSLog(@"Number of assets in group: %d",
                  [group numberOfAssets]);
            
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop){
                NSLog(@"asset index: %u", index);
                NSLog(@"Asset: %@", result);
                
            }];
        }
    } failureBlock:^(NSError *error) {NSLog(@"A problem occurred");}];

}

@end
