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
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:.90f green:.90f blue:.90f alpha:1];
    
    gameIdField = [[UITextField alloc] initWithFrame:
                   CGRectMake(10, 10, (self.view.frame.size.width - 20), 31)];
    gameIdField.borderStyle = UITextBorderStyleRoundedRect;
    gameIdField.placeholder = @"Game ID";
    gameIdField.autocorrectionType = NO;
    gameIdField.autocapitalizationType = NO;
    
    // login button
    loginButton = [UIButton buttonWithType:UIButtonTypeCustom];;
    loginButton.frame = CGRectMake(10, 56, (self.view.frame.size.width - 20), 31);
    [loginButton setBackgroundImage:[UIImage imageNamed:@"save.png"] forState:UIControlStateNormal];
    [self colorButton:loginButton];    
    [loginButton addTarget:self action:@selector(submitGameId:) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"Start new game" forState:UIControlStateNormal];

    // end game button
    endGameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    endGameButton.frame = CGRectMake(10, 92, (self.view.frame.size.width - 20), 31);
    [endGameButton setTitle:@"End Game" forState:UIControlStateNormal];
    [endGameButton addTarget:self action:@selector(endGame:) forControlEvents:UIControlEventTouchUpInside];
    
    [endGameButton setBackgroundImage:[UIImage imageNamed:@"end.png"] forState:UIControlStateNormal];
    [self colorButton:endGameButton];
    
    BOOL gameStatus = [AppHelper gameInProgress];
    
    if(gameStatus){
        [loginButton setEnabled:NO];
        [gameIdField setEnabled:NO];
    } else {
        [endGameButton setEnabled:NO];
    }
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    spinner.frame = CGRectMake((self.view.frame.size.width - 50) / 2, 140, 50, 50);
    
    statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, (self.view.frame.size.width - 20), 31)];
    statusLabel.backgroundColor = [UIColor clearColor];
    
    statusLabel.text = @"Test";
    
    
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
            
            NSLog(@"login resp: %@", jsonResp);
            
            
        }];
        
        [request setFailedBlock:^{
            [spinner stopAnimating];
            NSError *err = [request error];
            
            NSLog(@"Error: %@", [err localizedDescription]);
        }];
        [spinner startAnimating];
        [request startAsynchronous];
    } else {
        NSLog(@"Nope");
    }
}

- (IBAction)endGame:(id)sender
{
    NSLog(@"end game clicked");
}

@end
