//
//  ArtistListViewController.m
//  MusicList
//
//  Created by Matt Schoch on 1/10/13.
//  Copyright (c) 2013 Matt Schoch. All rights reserved.
//

#import "ArtistListViewController.h"
#import "Song.h"
#import "ArtistsTableViewCell.h"
#import "SongsListViewController.h"
#import "SongListTableViewCell.h"

@implementation ArtistListViewController

//@synthesize artistArray = _artistArray;
//@synthesize sectionedArtistArray = _sectionedArtistArray;
//@synthesize query = _query;
@synthesize query,artistArray,sectionedArtistArray,collation;
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

    if([[segue identifier] isEqualToString:@"PickArtist"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SongsListViewController *lvc = (SongsListViewController *) [segue destinationViewController];
        //get artist from sectioned array, the pull out the artist property and store in artistname variable.
        MPMediaItem *temp = [[self.sectionedArtistArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        lvc.artistName = [temp valueForProperty:MPMediaItemPropertyArtist];
        lvc.listType = @"FromArtists";

    }
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.query = [MPMediaQuery artistsQuery];
    
//       [self.query addFilterPredicate: [MPMediaPropertyPredicate
//                                    predicateWithValue: @"Twenty One Pilots"
//                                forProperty: MPMediaItemPropertyArtist]];
    
    // Sets the grouping type for the media query
    [self.query setGroupingType: MPMediaGroupingArtist];
    
    self.artistArray = [self.query collections];
    NSMutableArray *artists = [NSMutableArray array];
    
    for (MPMediaItemCollection *artist in artistArray) {
        //Grab the individual MPMediaItem representing the collection
        //MPMediaItem *myrepresentativeItem = artist.representativeItem;
        
        //Store it in the "artists" array
        [artists addObject:artist.representativeItem];
    }
    sectionedArtistArray = [self partitionObjects: artists collationStringSelector:@selector(artist)];
    
    

    
    
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
    return [[self.sectionedArtistArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ArtistsTableViewCell";
    

    ArtistsTableViewCell *cell =  nil;
    if ([tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)])
        cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    else
        cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    MPMediaItem *temp = [[self.sectionedArtistArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    //Title the current cell with the Album artist
    cell.artistTextLabel.text = [temp valueForProperty:MPMediaItemPropertyArtist];

    
    return cell;
}



@end
