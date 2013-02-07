//
//  NowPlayingViewController.m
//  MusicList
//
//  Created by Matt Schoch on 1/10/13.
//  Copyright (c) 2013 Matt Schoch. All rights reserved.
//

#import "NowPlayingViewController.h"
#import <CoreMedia/CMTime.h>


@interface NowPlayingViewController ()

@end

@implementation NowPlayingViewController
@synthesize musicPlayer;
@synthesize song = _song;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// =============================================================================
// Called each time the controller is loaded
// =============================================================================
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // AVPlayer is created in play nexe song if there is not already one
    [self avPlayerNextSong];
    
    // These let us get events from remote control when in background
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    [self registerMediaPlayerNotifications];

    // Update slider to reflect current volume

//
//    [_volumeSlider setValue: [musicPlayer volume]];
//    if([musicPlayer playbackState] == MPMusicPlaybackStatePlaying) {
//        [_playpauseButton setImage: [UIImage imageNamed:@"pauseButton.png"] forState:UIControlStateNormal];
//        
//    } else {
//        [_playpauseButton setImage:[UIImage imageNamed:@"playbutton.png"] forState:UIControlStateNormal];
//    }
//    
//    [self registerMediaPlayerNotifications];
//    [musicPlayer setQueueWithQuery:self.query];
//    [musicPlayer setNowPlayingItem:self.songChosen];
//        [musicPlayer play];
}

- (void)itemDidFinishPlaying
{
        NSLog(@"song finished");        
}

- (void)itemFailedFinishPlaying
{
    NSLog(@"song did not findish");
}



// =============================================================================
// Notification and event stuff
// =============================================================================
// -----------------------------------------------------------------------------
// registerMediaPlayerNotifications
// -----------------------------------------------------------------------------
- (void) registerMediaPlayerNotifications{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    
    // Will give us a notification when hardware volume changed
    [notificationCenter addObserver: self
                           selector: @selector(volumeChanged:)
                               name: @"AVSystemController_SystemVolumeDidChangeNotification"
                             object: nil];
    
//    [notificationCenter addObserver: self
//                           selector: @selector(handle_PlaybackStateChanged:)
//                               name: MPMusicPlayerControllerPlaybackStateDidChangeNotification
//                             object: musicPlayer];
//    [notificationCenter addObserver: self
//                           selector: @selector(handle_VolumeChanged:)
//                               name: MPMusicPlayerControllerVolumeDidChangeNotification
//                             object: musicPlayer];
//    [musicPlayer beginGeneratingPlaybackNotifications];
}

// -----------------------------------------------------------------------------
// volumeChanged -- called when volume changed by hardware
// -----------------------------------------------------------------------------
- (void)volumeChanged:(NSNotification *)notification
{
    float volume =
    [[[notification userInfo]
      objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"]
     floatValue];
    
    // Do stuff with volume
    NSLog(@"Volume changed: %f", volume);
}

- (void) handle_NowPlayingItemChanged: (id) notification{
//    MPMediaItem *currentItem = [musicPlayer nowPlayingItem];
//    UIImage *artworkImage = [UIImage imageNamed:@"noArtworkImage.png"];
//    
//    NSLog(@"NowPlayingItemChanged");
//    NSLog([self extractMediaIdentity: currentItem]);
//    
//    MPMediaItemArtwork *artwork = [currentItem valueForProperty:MPMediaItemPropertyArtwork];
//    if (artwork){
//        artworkImage = [artwork imageWithSize: CGSizeMake(200, 200)];
//    }
//    [_artworkImageView setImage:artworkImage];
//    
//    NSString *titleString = [currentItem valueForProperty:MPMediaItemPropertyTitle];
//    if (titleString) {
//        _titleLabel.text = [NSString stringWithFormat:@"Title: %@", titleString];
//    } else {
//        _titleLabel.text = @"Title: Unknown title";
//    }
//    
//    NSString *artistString = [currentItem valueForProperty:MPMediaItemPropertyArtist];
//    if (artistString) {
//        _artistLabel.text = [NSString stringWithFormat:@"Artist: %@", artistString];
//    } else {
//        _artistLabel.text = @"Artist: Unknown artist";
//    }
//    
//    NSString *albumString = [currentItem valueForProperty:MPMediaItemPropertyAlbumTitle];
//    if (albumString) {
//        _albumLabel.text = [NSString stringWithFormat:@"Album: %@", albumString];
//    } else {
//        _albumLabel.text = @"Album: Unknown album";
//    }
}

- (NSString *) extractMediaIdentity: (MPMediaItem*) mediaItem 
{
    NSString *titleString = [mediaItem valueForProperty:MPMediaItemPropertyTitle];
    NSString *artistString = [mediaItem valueForProperty:MPMediaItemPropertyArtist];
    NSString *genreString = [mediaItem valueForProperty:MPMediaItemPropertyGenre];
    NSNumber *duration = [mediaItem valueForProperty:MPMediaItemPropertyPlaybackDuration];
    return [[NSArray arrayWithObjects: @"\n", duration, titleString, artistString, genreString, nil] componentsJoinedByString:@"\n"];

}

- (void) handle_PlaybackStateChanged: (id) notification{
//    MPMediaItem *currentItem = [musicPlayer nowPlayingItem];
//    
//    NSString * state = [musicPlayer playbackState] == MPMusicPlaybackStatePlaying ? @"Playback state -- Playing" : @"Playback state -- Stopped";
//    NSLog(state);
//    NSLog([self extractMediaIdentity: currentItem]);
//
//    MPMusicPlaybackState playbackState = [musicPlayer playbackState];
//    if (playbackState == MPMusicPlaybackStatePaused) {
//        [_playpauseButton setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
//    } else if (playbackState == MPMusicPlaybackStatePlaying){
//        [_playpauseButton setImage:[UIImage imageNamed:@"pauseButton.png"] forState:UIControlStateNormal];
//    } else if (playbackState == MPMusicPlaybackStateStopped){
//        [_playpauseButton setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
//        [musicPlayer stop];
//    }
}

- (void) handle_VolumeChanged: (id) notification{
//    [_volumeSlider setValue:[musicPlayer volume]];
    NSLog(@"handle_volumechanged");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showMediaPicker:(id)sender {
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeAny];
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = YES;
    mediaPicker.prompt = @"Select songs to play";
    [self presentViewController:mediaPicker animated:YES completion:NULL];
}

- (void) mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection{
    if (mediaItemCollection) {
        NSLog(@"mediaPicker:didPickMediaItems");
//        [musicPlayer setQueueWithItemCollection:mediaItemCollection];
//        [musicPlayer play];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void) mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)previousSong:(id)sender {
//    [musicPlayer skipToPreviousItem];
    NSLog(@"previousSong");
}

- (IBAction)playPause:(id)sender {
    NSLog(@"playPause");
    if([self.musicPlayer rate])
    {
        [self.musicPlayer pause];
    }
       else
    {
        [self.musicPlayer play];
    }
}

- (IBAction)nextSong:(id)sender {
    NSLog(@"nextSong");
//    [musicPlayer skipToNextItem];
}

// =============================================================================
// AVPlayer
// =============================================================================
- (void) avPlayerStart
{
//	self.audioPlayerMusicCurrentItemIndex = 0;
//	self.audioPlayerMusicItems = [[[AppPrefs sharedInstance].appMediaItemCollection items] mutableCopy];
	[self avPlayerNextSong];
}


- (void)avPlayerNextSong
{
    // used to prevent duplicate notifications
//	self.isLoadingAsset = YES;
    
    // create the url to the file
    NSURL *anUrl = [self.songChosen valueForProperty:MPMediaItemPropertyAssetURL];
//	NSURL *anUrl = [[self.audioPlayerMusicItems objectAtIndex: self.audioPlayerMusicCurrentItemIndex] valueForProperty:MPMediaItemPropertyAssetURL];
    
    // Prepare Index for Next Song (wrap to continue playing: loop)
//	self.audioPlayerMusicCurrentItemIndex++;
//    
//	if(self.audioPlayerMusicCurrentItemIndex >= [self.audioPlayerMusicItems count])
//		self.audioPlayerMusicCurrentItemIndex = 0;
    
    AVAsset *asset = [AVURLAsset URLAssetWithURL:anUrl options:nil];
	NSArray *keys = [NSArray arrayWithObject:@"tracks"];
    
    AVPlayerItem* playerItem = [AVPlayerItem playerItemWithURL:anUrl];
    
    // Subscribe to the AVPlayerItem's DidPlayToEndTime notification.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(itemDidFinishPlaying)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:playerItem];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(itemFailedFinishPlaying)
                                                 name:AVPlayerItemFailedToPlayToEndTimeNotification
                                               object:playerItem];
    
    
    [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^(void)
    {
		NSError *error = nil;
        
        // get the status to see if the asset was loaded
		AVKeyValueStatus trackStatus = [asset statusOfValueForKey:@"tracks" error:&error];
        
		switch (trackStatus)
        {
			case AVKeyValueStatusLoaded:
				// AVAsset was loaded
				// If you want to change your UI you could do so here
				// [self updateUserInterfaceForTracks];
				if(self.musicPlayer) {
                    // AVPlayer has already been setup, so replace player with this AVAsset
					[self.musicPlayer replaceCurrentItemWithPlayerItem: playerItem];
				} else {
                    // AVPlayer has not been setup so initialize with this AVAsset
                    self.musicPlayer = [AVPlayer playerWithPlayerItem: playerItem];
				}
				[self.musicPlayer play];
				break;
                
			case AVKeyValueStatusFailed:
				// error occured loading AVAsset
				break;
                
			case AVKeyValueStatusCancelled:
				// loading of the AVAsset was cancelled
				break;
                
			default:
				break;
		}
//		self.isLoadingAsset = NO;
	}];
}


@end
