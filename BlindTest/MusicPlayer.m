//
//  MusicPlayer.m
//  BlindTest
//
//  Created by Adrien Brault on 20/05/11.
//  Copyright 2011 Adrien Brault. All rights reserved.
//

#import "MusicPlayer.h"


static MusicPlayer *sharedPlayer;


@implementation MusicPlayer

#pragma mark - Singleton

+ (MusicPlayer *)sharedPlayer
{
    if (!sharedPlayer) {
        sharedPlayer = [[MusicPlayer alloc] init];
    }
    return sharedPlayer;
}


#pragma mark - Properties

@synthesize music = _music;

- (void)setMusic:(Music *)music
{
    if (music != _music) {
        [_music release];
        _music = [music retain];
        
        [_audioPlayer release];
        NSError *error;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_music.url error:&error];
        
        if (error) {
            NSLog(@"MusicPlayer Error: %@", error);
        }
    }
}

#pragma mark - Object lifecyle

- (void)dealloc
{
    [_audioPlayer release];
    [super dealloc];
}

#pragma mark - Player



- (void)playMusic:(Music *)music
{
    [self stop];
    self.music = music;
    [self play];
}

- (void)pause
{
    [_audioPlayer pause];
}

- (void)play
{
    [_audioPlayer play];
}

- (void)stop
{
    [_audioPlayer stop];
}

@end
