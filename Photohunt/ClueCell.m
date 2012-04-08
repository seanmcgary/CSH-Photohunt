//
//  ClueCell.m
//  Photohunt
//
//  Created by Sean McGary on 4/5/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "ClueCell.h"

@implementation ClueCell

@synthesize clueInfo;

- (id) initWithClueInfo: (NSDictionary *)clueInfo {
    self = [super init];
    NSLog(@"creating clue cell");
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if(self){
        self.clueInfo = [[NSDictionary alloc] initWithDictionary:clueInfo];

    }
    
    return self;
}

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

@end
