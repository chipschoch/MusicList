//
//  ArtistsTableViewCell.h
//  MusicList
//
//  Created by Matt Schoch on 1/16/13.
//  Copyright (c) 2013 Matt Schoch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtistsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *artistTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumArtistTextLabel;

@end
