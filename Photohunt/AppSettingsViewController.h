//
//  AppSettingsViewController.h
//  Photohunt
//
//  Created by Sean McGary on 4/7/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppHelper.h"
#import "ASIHTTPRequest.h"

@interface AppSettingsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *endGameButton;
@property (strong, nonatomic) IBOutlet UITextField *gameIdField;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
- (id) init;

- (IBAction)submitGameId:(id)sender;

- (IBAction)endGame:(id)sender;

- (void) colorButton: (UIButton *)button;

@end
