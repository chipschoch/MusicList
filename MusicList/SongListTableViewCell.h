//
//  SongListTableViewCell.h
//  MusicList
//
//  Created by Matt Schoch on 1/17/13.
//  Copyright (c) 2013 Matt Schoch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongListTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *songTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *artistTextLabel;
@end
