//
//  GameViewController.m
//  BlindTest
//
//  Created by Adrien Brault on 19/05/11.
//  Copyright 2011 Adrien Brault. All rights reserved.
//

#import "GameViewController.h"


#define MAX_CHOICES 4


@interface GameViewController ()

@property (nonatomic, readonly) NSArray *musics;
@property (nonatomic, retain) Music *musicToGuess;
@property (nonatomic, retain) NSMutableArray *musicChoices;
@property (nonatomic, readonly) NSInteger maxChoices;

- (void)createMusicChoices;

@end


@implementation GameViewController
@synthesize choicesTableView = _choicesTableView;

#pragma mark - Properties

@synthesize musics = _musics;
@synthesize musicToGuess = _musicToGuess;
@synthesize musicChoices = _musicChoices;
@synthesize maxChoices = _maxChoices;


#pragma mark - Object lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.navigationItem.title = @"Blind Test";
        
        _musics = [[Music loadMusicsFromBundle] retain];
        
        _maxChoices = MIN(MAX_CHOICES, [self.musics count]);
    }
    return self;
}

- (void)dealloc
{
    [_musics release];
    [_musicToGuess release];
    [_musicChoices release];
    [_choicesTableView release];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.choicesTableView.dataSource = self;
}

- (void)viewDidUnload
{
    self.choicesTableView.dataSource = nil;
    self.choicesTableView = nil;
    [super viewDidUnload];
}


#pragma mark - IBAction

- (IBAction)nextSong
{
    NSInteger randomIndex = arc4random() % [self.musics count];
    self.musicToGuess = [self.musics objectAtIndex:randomIndex];
    
    [[MusicPlayer sharedPlayer] playMusic:self.musicToGuess];
    
    [self createMusicChoices];
    [self.choicesTableView reloadData];
}


#pragma mark - Private

- (void)createMusicChoices
{
    self.musicChoices = [NSMutableArray array];
    [self.musicChoices addObject:self.musicToGuess];
    
    while ([self.musicChoices count] < self.maxChoices) {
        NSInteger randomIndex = arc4random() % [self.musics count];
        Music *randomMusic = [self.musics objectAtIndex:randomIndex];
        if (![self.musicChoices containsObject:randomMusic]) {
            [self.musicChoices addObject:randomMusic];
        }
    }
    
    [self.musicChoices shuffle];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.musicChoices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MusicCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
    }

    Music *cellMusic = [self.musicChoices objectAtIndex:indexPath.row];
    
    cell.textLabel.text = cellMusic.title;
    cell.detailTextLabel.text = cellMusic.artist;

    return cell;
}

@end
