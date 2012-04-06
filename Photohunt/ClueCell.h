//
//  ClueCell.h
//  Photohunt
//
//  Created by Sean McGary on 4/5/12.
//  Copyright (c) 2012 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClueCell : UITableViewCell

@property (strong, nonatomic) NSDictionary *clueInfo;

- (id) initWithClueInfo: (NSDictionary *)clueInfo;

@end
