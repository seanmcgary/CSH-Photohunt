//
//  EditPhotoViewController.h
//  Photohunt
//
//  Created by Sean McGary on 4/8/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppHelper.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface EditPhotoViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *photoWithMetaData;
@property (strong, nonatomic) NSString *teamToken;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *judgeLabel;
@property (strong, nonatomic) IBOutlet UILabel *notesLabel;
@property (strong, nonatomic) IBOutlet UITextView *notesField;
@property (strong, nonatomic) IBOutlet UISwitch *judgeSwitch;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;

@property (readwrite, assign) BOOL inNotes;

- (id) initWithPhoto: (NSMutableDictionary *)photoWithMetaData;

- (void) uploadPhoto;

- (IBAction)doneButtonPressed:(id)sender;


@end
