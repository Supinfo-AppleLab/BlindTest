//
//  MusicPlayer.h
//  BlindTest
//
//  Created by Adrien Brault on 20/05/11.
//  Copyright 2011 Adrien Brault. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "Music.h"


/*
    This class is an AVAudioPlayer wrapper.
 
    It table to play the Music instance easier.
*/

@interface MusicPlayer : NSObject {
    AVAudioPlayer *_audioPlayer;
    Music *_music;
}

// Singleton

+ (MusicPlayer *)sharedPlayer;


// Properties

@property (nonatomic, retain) Music *music;


// Player

- (void)playMusic:(Music *)music;
- (void)pause;
- (void)play;
- (void)stop;

@end
