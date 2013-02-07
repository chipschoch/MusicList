//
//  PlaylistViewController.h
//  MusicList
//
//  Created by Jerald Schoch on 2/7/13.
//  Copyright (c) 2013 Matt Schoch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PlaylistViewController : UITableViewController <MPMediaPickerControllerDelegate>
{
    // instance variables
    MPMediaQuery *query;
    NSArray *artistArray;
    NSArray *sectionedArtistArray;
    UILocalizedIndexedCollation *collation;
}

// =============================================================================
// properties
// =============================================================================
@property (nonatomic, retain) NSArray *playlistArray;
@property (nonatomic, retain) MPMediaQuery *query;
@property (nonatomic, strong) NSString *playlistName;


// =============================================================================
// methods
// =============================================================================
- (NSUInteger) countOfList;

@end
