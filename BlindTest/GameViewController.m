//
//  GameViewController.m
//  BlindTest
//
//  Created by Adrien Brault on 19/05/11.
//  Copyright 2011 Adrien Brault. All rights reserved.
//

#import "GameViewController.h"


#define MAX_CHOICES 4
#define PROGRESS_VIEW_UPDATE_INTERVAL 0.03
#define MAX_TIME_TO_GUESS 30.0

@interface GameViewController ()

@property (nonatomic, readonly) NSArray *musics;
@property (nonatomic, retain) Music *musicToGuess;
@property (nonatomic, retain) NSMutableArray *musicChoices;
@property (nonatomic, readonly) NSInteger maxChoices;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, retain) NSTimer *timeLeftProgressViewTimer;

- (void)createMusicChoices;
- (void)didChooseCorrectMusic:(BOOL)isChoiceCorrect;

- (void)startTimeLeftProgressView;
- (void)stopTimeLeftProgressView;
- (void)timeLeftProgressViewTimerFire;

@end


@implementation GameViewController

#pragma mark - IBOutlet properties

@synthesize choicesTableView = _choicesTableView;
@synthesize scoreLabel = _scoreLabel;
@synthesize timeLeftProgressView = _timeLeftProgressView;


#pragma mark - Properties

@synthesize musics = _musics;
@synthesize musicToGuess = _musicToGuess;
@synthesize musicChoices = _musicChoices;
@synthesize maxChoices = _maxChoices;
@synthesize score = _score;

- (void)setScore:(NSInteger)score
{
    _score = MAX(score, 0);
        
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", _score];
}

@synthesize timeLeftProgressViewTimer = _timeLeftProgressViewTimer;


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
    [_scoreLabel release];
    [_timeLeftProgressView release];
    [_timeLeftProgressViewTimer release];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.choicesTableView.dataSource = self;
    self.choicesTableView.delegate = self;
    
    self.choicesTableView.hidden = YES;
    
    self.score = 0;
}

- (void)viewDidUnload
{
    self.choicesTableView.dataSource = nil;
    self.choicesTableView.delegate = nil;
    self.choicesTableView = nil;
    self.scoreLabel = nil;
    self.timeLeftProgressView = nil;
    [super viewDidUnload];
}


#pragma mark - IBAction

- (IBAction)nextSong
{
    NSInteger randomIndex = arc4random() % [self.musics count];
    self.musicToGuess = [self.musics objectAtIndex:randomIndex];
    
    [[MusicPlayer sharedPlayer] playMusic:self.musicToGuess];
    [self startTimeLeftProgressView];
    
    [self createMusicChoices];
    [self.choicesTableView reloadData];
    self.choicesTableView.hidden = NO;
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

- (void)didChooseCorrectMusic:(BOOL)isChoiceCorrect
{
    self.choicesTableView.hidden = YES;
    
    [self stopTimeLeftProgressView];
    [[MusicPlayer sharedPlayer] stop];
    
    self.score += isChoiceCorrect ? +10 : -5;
    
    NSString *alertViewTitle = isChoiceCorrect ? @"Won!" : @"Lose!";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertViewTitle
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}


#pragma mark - Timer Private

- (void)startTimeLeftProgressView
{
    [self stopTimeLeftProgressView];
    
    self.timeLeftProgressView.progress = 1.0;
    
    self.timeLeftProgressViewTimer = [NSTimer scheduledTimerWithTimeInterval:PROGRESS_VIEW_UPDATE_INTERVAL
                                                                      target:self
                                                                    selector:@selector(timeLeftProgressViewTimerFire)
                                                                    userInfo:nil
                                                                     repeats:YES];
}

- (void)stopTimeLeftProgressView
{
    [self.timeLeftProgressViewTimer invalidate];
    self.timeLeftProgressViewTimer = nil;
}

- (void)timeLeftProgressViewTimerFire
{
    CGFloat timeInterval = 1 / (MIN(self.musicToGuess.duration, MAX_TIME_TO_GUESS) / PROGRESS_VIEW_UPDATE_INTERVAL);
    self.timeLeftProgressView.progress -= timeInterval;
    
    if (self.timeLeftProgressView.progress <= 0.0) {
        [self didChooseCorrectMusic:NO];
    }
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


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Music *selectedMusic = [self.musicChoices objectAtIndex:indexPath.row];
    [self didChooseCorrectMusic:(selectedMusic == self.musicToGuess)];
}

@end
