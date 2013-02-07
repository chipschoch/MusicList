//
//  PlaylistViewController.m
//  MusicList
//
//  Created by Jerald Schoch on 2/7/13.
//  Copyright (c) 2013 Matt Schoch. All rights reserved.
//

#import "PlaylistViewController.h"
#import "SongslistViewController.h"
#import "SongListTableViewCell.h"
#import "MediaPlayer/MPMediaPlaylist.h"

@interface PlaylistViewController ()

@end

@implementation PlaylistViewController

// =============================================================================
// synthesize instance variables
// =============================================================================
@synthesize query;
@synthesize playlistArray;

// -----------------------------------------------------------------------------
// initWithStyle:style
// -----------------------------------------------------------------------------
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

// -----------------------------------------------------------------------------
// viewDidLoad
// -----------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Get playlist query
    self.query = [MPMediaQuery playlistsQuery];
    
    // Sets the grouping type for the media query
    [self.query setGroupingType: MPMediaGroupingPlaylist];
    
    // Query for playlists and store MPMediaItem in list
    self.playlistArray = [self.query collections];
    NSMutableArray *playlists = [NSMutableArray array];
    
    for (MPMediaItemCollection *playlist in playlistArray)
    {
         [playlists addObject:playlist.representativeItem];
    }
}

// -----------------------------------------------------------------------------
// didReceiveMemoryWarning -- TODO: Figure out what to do when this happens
// -----------------------------------------------------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
// -----------------------------------------------------------------------------
// numberOfSectionsInTableView
// -----------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// -----------------------------------------------------------------------------
// countOfList
// -----------------------------------------------------------------------------
- (NSUInteger) countOfList
{
    return [self.playlistArray count];
}

// -----------------------------------------------------------------------------
// tableView:numberOfRowsInSection:
// -----------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self countOfList];
}

// -----------------------------------------------------------------------------
// tableView:canEditRowAtIndexPath
// -----------------------------------------------------------------------------
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

// -----------------------------------------------------------------------------
// tableView:cellForRowAtIndexPath:
// -----------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlaylistsTableViewCell";
    
    
    UITableViewCell *cell =  nil;
    
    // IOS 6 provided new interface so we need to check if it is availabel here
    // and fallback to the old one if not
    if ([tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)])
        cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    else
        cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    // Get the playlist item
    MPMediaPlaylist *temp = [self.playlistArray objectAtIndex:indexPath.row];
    
    // Get the name
    NSString * name = [temp valueForProperty:MPMediaPlaylistPropertyName];
    
    //Title the current cell with the name of the Playlist
    [[cell textLabel] setText: name];
        
    return cell;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([[segue identifier] isEqualToString:@"PickPlaylist"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SongsListViewController *lvc = (SongsListViewController *) [segue destinationViewController];
        
        // Get the playlist item
        MPMediaPlaylist *temp = [self.playlistArray objectAtIndex:indexPath.row];

        
        //get artist from sectioned array, the pull out the artist property and store in artistname variable.
        MPMediaItem *temp = [[self.sectionedArtistArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        lvc.artistName = [temp valueForProperty:MPMediaItemPropertyArtist];
        lvc.listType = @"FromPlaylists";
        
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
