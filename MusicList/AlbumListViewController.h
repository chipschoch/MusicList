//
//  AlbumListViewController.h
//  MusicList
//
//  Created by Matt Schoch on 1/30/13.
//  Copyright (c) 2013 Matt Schoch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AlbumListViewController : UITableViewController <MPMediaPickerControllerDelegate>
{
    MPMediaQuery *query;
    NSArray *albumArray,*sectionedAlbumArray;
    UILocalizedIndexedCollation *collation;
}

@property (nonatomic, retain) NSArray *albumArray;
@property (nonatomic, retain) MPMediaQuery *query;
@property (nonatomic, retain) NSArray *sectionedAlbumArray;
@property (nonatomic, retain) UILocalizedIndexedCollation *collation;
@property (nonatomic, strong) NSString *albumName;


- (NSArray *)partitionObjects:(NSArray *)array collationStringSelector:(SEL)selector;
@end