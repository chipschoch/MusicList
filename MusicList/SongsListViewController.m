//
//  SongsListViewController.m
//  MusicList
//
//  Created by Matt Schoch on 1/17/13.
//  Copyright (c) 2013 Matt Schoch. All rights reserved.
//

#import "SongsListViewController.h"
#import "Song.h"
#import "SongListTableViewCell.h"
#import "NowPlayingViewController.h"
@interface SongsListViewController ()

@end

@implementation SongsListViewController


@synthesize songsArray;
@synthesize query;

@synthesize sectionedSongsArray,collation;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"PlaySong"]){
        NowPlayingViewController *npvc = (NowPlayingViewController *) [segue destinationViewController];
        //        npvc.songChosen = [self.query.items objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        npvc.query = self.query;
        
        npvc.songChosen = [[self.sectionedSongsArray objectAtIndex:[[self.tableView indexPathForSelectedRow] section]] objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.query = [[MPMediaQuery alloc] init];
    
    if (self.artistName) {
        NSLog(@"%@",self.artistName);
        [self.query addFilterPredicate: [MPMediaPropertyPredicate
                                         predicateWithValue: self.artistName
                                         forProperty: MPMediaItemPropertyArtist]];
        
        
    } else if(self.albumName){
        NSLog(@"%@",self.albumName);
        [self.query addFilterPredicate: [MPMediaPropertyPredicate
                                         predicateWithValue: self.albumName
                                         forProperty: MPMediaItemPropertyAlbumTitle]];
        
    }
    
    [self.query setGroupingType: MPMediaGroupingAlbum];
    
    self.songsArray = [self.query collections];
    NSMutableArray *songs = [NSMutableArray array];
    
    for (MPMediaItemCollection *song in songsArray) {
        //Grab the individual MPMediaItem representing the collection
        //MPMediaItem *myrepresentativeItem = artist.representativeItem;
        
        //Store it in the "artists" array
        [songs addObject:song.representativeItem];
    }
    sectionedSongsArray = [self partitionObjects: songs collationStringSelector:@selector(title)];
    
    self.songsArray = [self.query items];
}

- (NSArray *)partitionObjects:(NSArray *)array collationStringSelector:(SEL)selector
{
    
    self.collation = [UILocalizedIndexedCollation currentCollation];
    NSInteger sectionCount = [[self.collation sectionTitles] count];
    NSMutableArray *unsortedSections = [NSMutableArray arrayWithCapacity:sectionCount];
    for(int i = 0; i < sectionCount; i++)
        [unsortedSections addObject:[NSMutableArray array]];
    
    for (id object in array)
    {
        NSInteger index = [self.collation sectionForObject:object collationStringSelector:selector];
        [[unsortedSections objectAtIndex:index] addObject:object];
    }
    NSMutableArray *sections = [NSMutableArray arrayWithCapacity:sectionCount];
    for (NSMutableArray *section in unsortedSections)
        [sections addObject:[self.collation sortedArrayFromArray:section collationStringSelector:selector]];
    
    return sections;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.collation sectionTitles] objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return [self.collation sectionIndexTitles];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.artistName) {
        return 1;
    }else{
    return [[self.collation sectionTitles] count];

    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.sectionedSongsArray objectAtIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SongTableViewCell";
    
    SongListTableViewCell *cell =  nil;
    if ([tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)])
        cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    else
        cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    if (cell == nil) {
        cell = [[SongListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    MPMediaItem *temp = [[self.sectionedSongsArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.songTextLabel.text = [temp valueForProperty:MPMediaItemPropertyTitle];
    cell.artistTextLabel.text = [temp valueForProperty:MPMediaItemPropertyArtist];
    
    //Song *song = [self.songsArray objectAtIndex:indexPath.row];
    //    Song *song = [self.query.items objectAtIndex:indexPath.row];
    //    cell.songTextLabel.text = song.title;
    //    cell.artistTextLabel.text = song.artist;
    return cell;
}





@end