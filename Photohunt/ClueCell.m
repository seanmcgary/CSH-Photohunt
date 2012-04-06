//
//  ClueCell.m
//  Photohunt
//
//  Created by Sean McGary on 4/5/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "ClueCell.h"

@implementation ClueCell

- (id) init {
    self = [super initWithFrame:CGRectMake(0, 0, 200, 400)];
    
    if(self){
        UIView *testView = [[UIView alloc] init];
        
        testView.frame = CGRectMake(0, 0, 200, 400);
        testView.backgroundColor = [UIColor redColor];
        
        [self.contentView addSubview:testView];
        //self.contentView.frame = CGRectMake(0, 0, 200, 400);
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
