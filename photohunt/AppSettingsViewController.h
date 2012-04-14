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
#import "AppLoginButton.h"
#import "AppEndGameButton.h"
#import "ClueSheet.h"

@interface AppSettingsViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet AppLoginButton *loginButton;
@property (strong, nonatomic) IBOutlet AppEndGameButton *endGameButton;
@property (strong, nonatomic) IBOutlet UITextField *gameIdField;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) UIAlertView *endGameAlert;

- (id) init;

- (IBAction)submitGameId:(id)sender;

- (IBAction)endGame:(id)sender;

- (void) colorButton: (UIButton *)button;

- (void) refreshButtonStates;

- (void) getClueSheetPostLogin;

@end
