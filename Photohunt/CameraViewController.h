//
//  CameraViewController.h
//  Photohunt
//
//  Created by Sean McGary on 3/24/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *fakeCamera;

- (id) init;

- (IBAction)takeFakePicture:(id)sender;

@end
