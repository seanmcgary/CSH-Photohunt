//
//  GameIdField.m
//  photohunt
//
//  Created by Sean McGary on 4/14/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "GameIdField.h"

@implementation GameIdField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.placeholder = @"Game Token";
        
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
