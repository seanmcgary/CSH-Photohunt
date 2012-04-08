//
//  AppSettingsViewController.m
//  Photohunt
//
//  Created by Sean McGary on 4/7/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "AppSettingsViewController.h"

@interface AppSettingsViewController ()

@end

@implementation AppSettingsViewController

@synthesize loginButton;
@synthesize endGameButton;
@synthesize gameIdField;
@synthesize spinner;
@synthesize statusLabel;
@synthesize endGameAlert;

- (id) init {
    self = [super init];
    
    if(self){
        self.title = @"Settings";
        
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        endGameAlert = [[UIAlertView alloc] 
                        initWithTitle:@"Confirm End Game" 
                        message:@"Do you really want to end the game?" 
                        delegate:self 
                        cancelButtonTitle:@"Nope" 
                        otherButtonTitles:@"Yeah, end it", nil];
        
        
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithRed:.90f green:.90f blue:.90f alpha:1];
        
        gameIdField = [[UITextField alloc] initWithFrame:
                       CGRectMake(10, 10, (self.view.frame.size.width - 20), 31)];
        gameIdField.borderStyle = UITextBorderStyleRoundedRect;
        gameIdField.placeholder = @"Game Token";
        gameIdField.autocorrectionType = NO;
        gameIdField.autocapitalizationType = NO;
        
        // login button    
        loginButton = [[AppLoginButton alloc] initWithFrame:CGRectMake(10, 56, (self.view.frame.size.width - 20), 31)];
        [self colorButton:loginButton];    
        [loginButton addTarget:self action:@selector(submitGameId:) forControlEvents:UIControlEventTouchUpInside];
        
        // end game button
        endGameButton = [[AppEndGameButton alloc] initWithFrame:CGRectMake(10, 92, (self.view.frame.size.width - 20), 31)];
        [self colorButton:endGameButton];
        [endGameButton addTarget:self action:@selector(endGame:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) refreshButtonStates
{
    BOOL gameStatus = [AppHelper gameInProgress];
    NSLog(@"gameStatus: %u", gameStatus);
    if(gameStatus){
        [loginButton setEnabled:NO];
        [gameIdField setEnabled:NO];
        [endGameButton setEnabled:YES];
    } else {
        [loginButton setEnabled:YES];
        [gameIdField setEnabled:YES];
        [endGameButton setEnabled:NO];
    }
}

-(void) viewWillAppear:(BOOL)animated 
{
    NSLog(@"view will appear");
    [self refreshButtonStates];
    // status label
    statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, (self.view.frame.size.width - 20), 31)];
    statusLabel.backgroundColor = [UIColor clearColor];
    
    // spinner
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    spinner.frame = CGRectMake((self.view.frame.size.width - 50) / 2, 150, 50, 50);
    
    [self.view addSubview:gameIdField];
    [self.view addSubview:loginButton];
    [self.view addSubview:endGameButton];
    [self.view addSubview:statusLabel];
    [self.view addSubview:spinner];
}

- (void) colorButton: (UIButton *)button
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = button.layer.bounds;
    
    CALayer *layer = button.layer;
    layer.cornerRadius = 8.0f;
    layer.masksToBounds = YES;
    layer.borderWidth = 1.0f;
    layer.borderColor = [UIColor colorWithWhite:0.4f alpha:0.2f].CGColor;
    
    gradient.colors = [NSArray arrayWithObjects:
                          (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                          (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                          (id)[UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                          (id)[UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                          (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                          nil];
    // Set the relative positions of the gradien stops
    gradient.locations = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:0.0f],
                             [NSNumber numberWithFloat:0.5f],
                             [NSNumber numberWithFloat:0.5f],
                             [NSNumber numberWithFloat:0.8f],
                             [NSNumber numberWithFloat:1.0f],
                             nil];
    
    // Add the layer to the button
    [button.layer addSublayer:gradient];

    button.titleLabel.font = [UIFont systemFontOfSize:16];
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

- (IBAction)submitGameId:(id)sender 
{
    NSString *gameId = gameIdField.text;
    
    if([gameId length] > 0){
        // lets login!!

        NSURL *url = [NSURL URLWithString:
                      [NSString stringWithFormat:@"https://photohunt.csh.rit.edu/api/info?token=%@", gameId]];
        
        __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        NSMutableDictionary *requestHeaders = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"application/json", @"Accept", nil];
        
        [request setRequestHeaders: requestHeaders];
        
        // TODO - make this actually check the cert
        [request setValidatesSecureCertificate:NO];
        [request setCompletionBlock:^{
            [spinner stopAnimating];
            NSData *respData = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *jsonErr;
            
            NSMutableDictionary *jsonResp = [NSJSONSerialization JSONObjectWithData:respData options:NSJSONReadingMutableContainers error:&jsonErr];
            NSLog(@"JSON:\n%@", jsonResp);
            NSMutableDictionary *gameData = [jsonResp objectForKey:@"data"];
            
            [gameData setValue:[NSNumber numberWithInt:0] forKey:@"photosTaken"];
            [gameData setValue:[NSNumber numberWithInt:0] forKey:@"photosJudged"];
            [gameData setValue:[NSNumber numberWithInt:0] forKey:@"pointsSubmitted"];
            [AppHelper setGameData: gameData];
            [AppHelper setGameProgress:YES];
            
            [self getClueSheetPostLogin];            
            
        }];
        
        [request setFailedBlock:^{
            [spinner stopAnimating];
            NSError *err = [request error];
            NSData *respData = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *jsonErr;
            
            NSMutableDictionary *jsonResp = [NSJSONSerialization JSONObjectWithData:respData options:NSJSONReadingMutableContainers error:&jsonErr];
            
            self.statusLabel.text = [jsonResp objectForKey:@"message"];
        }];
        [spinner startAnimating];
        [request startAsynchronous];
    } else {
        self.statusLabel.text = @"Please provide a token";
    }
}

- (IBAction)endGame:(id)sender
{
    [endGameAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 1) {
        [AppHelper endGame];
        [self.view reloadInputViews];
        [self refreshButtonStates];
	}
}

- (void) getClueSheetPostLogin
{
    NSURL *url = [NSURL URLWithString:@"https://photohunt.csh.rit.edu/api/clues"];
    
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    NSMutableDictionary *requestHeaders = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"application/json", @"Accept", nil];
    
    // TODO - make this actually check the cert
    [request setValidatesSecureCertificate:NO];
    [request setRequestHeaders: requestHeaders];
    [request setCompletionBlock:^{
        NSData *respData = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *jsonErr;
        
        NSMutableDictionary *jsonResp = [NSJSONSerialization JSONObjectWithData:respData options:NSJSONReadingMutableContainers error:&jsonErr];
        
        ClueSheet *clueSheet = [[ClueSheet alloc] init];
        
        [clueSheet parseClueJSON:jsonResp];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }];
    
    [request setFailedBlock:^{
        NSError *err = [request error];
        
        NSLog(@"Error: %@", [err localizedDescription]);
    }];
    
    [request startAsynchronous];
}

@end
