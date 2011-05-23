//
//  GameViewController.m
//  BlindTest
//
//  Created by Adrien Brault on 19/05/11.
//  Copyright 2011 Adrien Brault. All rights reserved.
//

#import "GameViewController.h"


@interface GameViewController ()

@property (nonatomic, readonly) NSArray *musics;
@property (nonatomic, retain) Music *musicToGuess;

@end


@implementation GameViewController

#pragma mark - Properties

@synthesize musics = _musics;
@synthesize musicToGuess = _musicToGuess;


#pragma mark - Object lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.navigationItem.title = @"Blind Test";
        
        _musics = [[Music loadMusicsFromBundle] retain];
    }
    return self;
}

- (void)dealloc
{
    [_musics release];
    [_musicToGuess release];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


#pragma mark - IBAction

- (IBAction)nextSong
{
    NSInteger randomIndex = arc4random() % [self.musics count];
    self.musicToGuess = [self.musics objectAtIndex:randomIndex];
    
    [[MusicPlayer sharedPlayer] playMusic:self.musicToGuess];
}

@end
