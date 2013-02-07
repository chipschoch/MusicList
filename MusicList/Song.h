//
//  Song.h
//  MusicList
//
//  Created by Matt Schoch on 1/10/13.
//  Copyright (c) 2013 Matt Schoch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *artist;


+ (id) songWithTitle:(NSString *) title artist:(NSString *)artist;
@end
