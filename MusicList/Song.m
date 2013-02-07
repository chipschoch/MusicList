//
//  Song.m
//  MusicList
//
//  Created by Matt Schoch on 1/10/13.
//  Copyright (c) 2013 Matt Schoch. All rights reserved.
//

#import "Song.h"

@implementation Song

@synthesize title = _title;
@synthesize artist = _artist;


+ (id) songWithTitle:(NSString *) title artist:(NSString *)artist{
    
    Song __autoreleasing *s;
    s = [[Song alloc] init];
    
    if ( s ) {
        s.title = title;
        s.artist = artist;
    }
    return s;
}

@end
