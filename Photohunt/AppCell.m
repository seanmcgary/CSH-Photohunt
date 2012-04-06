//
//  AppCell.m
//  Photohunt
//
//  Created by Sean McGary on 3/25/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "AppCell.h"

@implementation AppCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setCellData: (NSString *) category: (NSString *) value
{
    
    UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0,                                          0, 150, 43)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-10, 0, 150, 43)];
    label.textAlignment = UITextAlignmentRight;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    
    label.text = value;    
    
    [accessoryView addSubview:label];
    
    self.accessoryView = accessoryView;
    
    [self setAccessoryType:UIButtonTypeCustom];
    
    self.textLabel.text = category;
    self.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

@end
