//
//  GameViewController.m
//  BlindTest
//
//  Created by Adrien Brault on 19/05/11.
//  Copyright 2011 Adrien Brault. All rights reserved.
//

#import "GameViewController.h"
#import "NSMutableArray+RandomSort.h"
#import "NSArray+RandomSort.h"
#import "Music.h"
#import "MusicPlayer.h"


@implementation GameViewController

#pragma mark - Object lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.navigationItem.title = @"Blind Test";
        
        /*
        // Recuperer les musiques.
        NSArray *musics = [Music loadMusicsFromBundle];
        
        // Recuperer la dernière musique du tableau.
        Music *lastMusic = [musics lastObject];
        
        // Demarer la lecture de la musique.
        [[MusicPlayer sharedPlayer] playMusic:lastMusic];
        
//        MusicPlayer *player = [MusicPlayer sharedPlayer];
//        [player pause];
//        [player play];
//        [player stop];
        
        // Recuperer une copie mélangée du tableau des musiques.
        NSArray *musicsShuffled = [musics shuffledCopy];
        
        // Generer un nombre aléatoire inclu dans [1-100]
        int randomNumber = arc4random() % 100 + 1;
        
        // Generer un index aléatoire.
        int randomMusicIndex = arc4random() % [musicsShuffled count];
        
        // Recuperer une musique d'un tableau.
        Music *aMusic = [musicsShuffled objectAtIndex:randomMusicIndex];
        
        // Afficher le titre, l'artiste et la durée d'une musique dans la console.
        NSLog(@"Titre: %@ - Artiste: %@ - Durée: %f s", aMusic.title, aMusic.artist, aMusic.duration);
        
        
        [musicsShuffled release];
        */
    }
    return self;
}

- (void)dealloc
{
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

@end
