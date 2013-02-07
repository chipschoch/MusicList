//
//  ArtistsTableViewCell.m
//  MusicList
//
//  Created by Matt Schoch on 1/16/13.
//  Copyright (c) 2013 Matt Schoch. All rights reserved.
//

#import "ArtistsTableViewCell.h"

@implementation ArtistsTableViewCell

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
