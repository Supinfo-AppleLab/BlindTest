//
//  GameViewController.h
//  BlindTest
//
//  Created by Adrien Brault on 19/05/11.
//  Copyright 2011 Adrien Brault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSMutableArray+RandomSort.h"
#import "NSArray+RandomSort.h"
#import "Music.h"
#import "MusicPlayer.h"


@interface GameViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *_musics;
    Music *_musicToGuess;
    NSMutableArray *_musicChoices;
    
    NSInteger _maxChoices;
    
    UITableView *_choicesTableView;
    UILabel *_scoreLabel;
    
    NSInteger _score;
}

@property (nonatomic, retain) IBOutlet UITableView *choicesTableView;
@property (nonatomic, retain) IBOutlet UILabel *scoreLabel;

- (IBAction)nextSong;

@end
