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
