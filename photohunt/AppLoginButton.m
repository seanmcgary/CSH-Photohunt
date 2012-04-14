//
//  AppLoginButton.m
//  Photohunt
//
//  Created by Sean McGary on 4/7/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import "AppLoginButton.h"

@implementation AppLoginButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"save.png"] forState:UIControlStateNormal];
        [self setTitle:@"Start new game" forState:UIControlStateNormal];
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
