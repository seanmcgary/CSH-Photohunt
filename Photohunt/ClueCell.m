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
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cluecell"];
    
    if(self){
        self.clueInfo = [[NSDictionary alloc] initWithDictionary:clueInfo];
        NSLog(@"Foobar");
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
