//
//  AlbumListViewController.m
//  MusicList
//
//  Created by Matt Schoch on 1/30/13.
//  Copyright (c) 2013 Matt Schoch. All rights reserved.
//

#import "AlbumListViewController.h"
#import "Song.h"
#import "ArtistsTableViewCell.h"
#import "SongsListViewController.h"
#import "SongListTableViewCell.h"

@implementation AlbumListViewController

//@synthesize albumArray = _albumArray;
//@synthesize sectionedAlbumArray = _sectionedAlbumArray;
//@synthesize query = _query;
@synthesize query,albumArray,sectionedAlbumArray,collation;
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
    
    if([[segue identifier] isEqualToString:@"PickAlbum"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SongsListViewController *lvc = (SongsListViewController *) [segue destinationViewController];
        //get album from sectioned array, the pull out the album property and store in albumName variable.
        MPMediaItem *temp = [[self.sectionedAlbumArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        lvc.albumName = [temp valueForProperty:MPMediaItemPropertyAlbumTitle];
        lvc.listType = @"FromAlbums";
    }
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.query = [MPMediaQuery albumsQuery];
    
    //       [self.query addFilterPredicate: [MPMediaPropertyPredicate
    //                                    predicateWithValue: @"Twenty One Pilots"
    //                                forProperty: MPMediaItemPropertyArtist]];
    
    // Sets the grouping type for the media query
    [self.query setGroupingType: MPMediaGroupingAlbum];
    
    self.albumArray = [self.query collections];
    NSMutableArray *albums = [NSMutableArray array];
    
    for (MPMediaItemCollection *album in albumArray) {
        //Grab the individual MPMediaItem representing the collection
        //MPMediaItem *myrepresentativeItem = artist.representativeItem;
        
        //Store it in the "artists" array
        [albums addObject:album.representativeItem];
    }
    sectionedAlbumArray = [self partitionObjects: albums collationStringSelector:@selector(albumTitle)];
    

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


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    
    return [[self.collation sectionTitles] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.sectionedAlbumArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AlbumsTableViewCell";
    
    ArtistsTableViewCell *cell =  nil;
    if ([tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)])
        cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    else
        cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    MPMediaItem *temp = [[self.sectionedAlbumArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    //Title the current cell with the Album artist
    cell.albumTextLabel.text = [temp valueForProperty:MPMediaItemPropertyAlbumTitle];
    cell.albumArtistTextLabel.text = [temp valueForProperty:MPMediaItemPropertyArtist];
    
    return cell;
}



@end
