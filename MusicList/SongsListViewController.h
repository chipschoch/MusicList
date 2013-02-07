//
//  SongsListViewController.h
//  MusicList
//
//  Created by Matt Schoch on 1/17/13.
//  Copyright (c) 2013 Matt Schoch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


@interface SongsListViewController : UITableViewController <MPMediaPickerControllerDelegate>
@property (nonatomic, strong) NSArray *songsArray;
@property (nonatomic, strong) MPMediaQuery *query;
@property (nonatomic, retain) NSArray *sectionedSongsArray;
@property (nonatomic, retain) UILocalizedIndexedCollation *collation;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSString *albumName;
@property (nonatomic, strong) NSString *listType;

- (NSArray *)partitionObjects:(NSArray *)array collationStringSelector:(SEL)selector;
@end
