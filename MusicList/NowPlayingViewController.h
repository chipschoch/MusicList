//
//  NowPlayingViewController.h
//  MusicList
//
//  Created by Matt Schoch on 1/10/13.
//  Copyright (c) 2013 Matt Schoch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "Song.h"

@interface NowPlayingViewController : UIViewController <MPMediaPickerControllerDelegate>

// =============================================================================
// properties
// =============================================================================
@property (strong, nonatomic) IBOutlet UIImageView *artworkImageView;
@property (strong, nonatomic) IBOutlet UIView *volumeViewContainer;
@property (strong, nonatomic) IBOutlet UIButton *playpauseButton;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *artistLabel;
@property (strong, nonatomic) IBOutlet UILabel *albumLabel;
@property (nonatomic, strong) MPMediaItem *songChosen;
@property (nonatomic, strong) MPMediaQuery *query;
@property (strong, nonatomic) Song *song;
@property (nonatomic, retain) AVPlayer *musicPlayer;

// =============================================================================
// methods
// =============================================================================
- (IBAction)previousSong:(id)sender;
- (IBAction)playPause:(id)sender;
- (IBAction)nextSong:(id)sender;
- (void) registerMediaPlayerNotifications;
- (void)itemDidFinishPlaying;
- (void)itemFailedFinishPlaying;

// AV Interfaces
- (void) avPlayerStart;
- (void)avPlayerNextSong;
@end
