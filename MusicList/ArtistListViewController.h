//
//  ArtistListViewController.h
//  MusicList
//
//  Created by Matt Schoch on 1/16/13.
//  Copyright (c) 2013 Matt Schoch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ArtistListViewController : UITableViewController <MPMediaPickerControllerDelegate>
{
    MPMediaQuery *query;
    NSArray *artistArray,*sectionedArtistArray;
    UILocalizedIndexedCollation *collation;
}
@property (nonatomic, retain) NSArray *artistArray;
@property (nonatomic, retain) MPMediaQuery *query;
@property (nonatomic, retain) NSArray *sectionedArtistArray;
@property (nonatomic, retain) UILocalizedIndexedCollation *collation;
@property (nonatomic, strong) NSString *artistName;


- (NSArray *)partitionObjects:(NSArray *)array collationStringSelector:(SEL)selector;
@end