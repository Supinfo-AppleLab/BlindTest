//
//  Music.m
//  BlindTest
//
//  Created by Adrien Brault on 19/05/11.
//  Copyright 2011 Adrien Brault. All rights reserved.
//

#import "Music.h"
#import <AudioToolbox/AudioToolbox.h>


@interface Music()

- (void)loadMetadataFromUrl;

@end


@implementation Music

#pragma mark - Properties

@synthesize url = _url;
@synthesize title = _title;
@synthesize artist = _artist;
@synthesize duration = _duration;


#pragma mark - Object lifecycle

- (id)init
{
    return [self initWithUrl:nil];
}

- (id)initWithUrl:(NSURL *)url
{
    if ((self = [super init])) {
        _url = [url copy];
        
        if (_url) {
            [self loadMetadataFromUrl];
        }
    }
    return self;
}

- (void)dealloc
{
    [_url release];
    [_title release];
    [_artist release];
    [super dealloc];
}


#pragma mark -

- (NSString *)description
{
    return [NSString stringWithFormat:@"[Music - Title: <%@> - Artist: <%@> - Duration: <%f>]", _title, _artist, _duration];
}


#pragma mark - Private

- (void)loadMetadataFromUrl
{
    // Following procedure found at http://www.iphonedevbook.com/forum/iphone-development-questions/805-reading-mp3-id-tags.html#post2577 .
    
    // Getting fileID.
    
    AudioFileID fileID = nil;
    OSStatus err = noErr;
    
    err = AudioFileOpenURL((CFURLRef)self.url, kAudioFileReadPermission, 0, &fileID);
    if(err != noErr) {
        NSLog(@"AudioFileOpenURL failed");
        return;
    }
    
    
    // Getting music metadata.
    
    CFDictionaryRef piDict = nil;
    UInt32 piDataSize = sizeof(piDict);
    
    err = AudioFileGetProperty(fileID, kAudioFilePropertyInfoDictionary, &piDataSize, &piDict);
    if(err != noErr) {
        NSLog(@"AudioFileGetProperty failed for property info dictionary");
        return;
    }
    AudioFileClose(fileID);
    
    // Using metadata.
    
    NSDictionary *metadataDic = (NSDictionary *)piDict;
    
    _title = [[metadataDic objectForKey:[NSString stringWithUTF8String:kAFInfoDictionary_Title]] copy];
    _artist = [[metadataDic objectForKey:[NSString stringWithUTF8String:kAFInfoDictionary_Artist]] copy];
    _duration = [[metadataDic objectForKey:[NSString stringWithUTF8String:kAFInfoDictionary_ApproximateDurationInSeconds]] floatValue];
    
    CFRelease(piDict);
}


#pragma mark - Class

+ (NSArray *)loadMusicsFromBundle
{
    NSMutableArray *musicsArray = [[NSMutableArray alloc] init];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSArray *urls = [mainBundle URLsForResourcesWithExtension:@"mp3" subdirectory:nil];
    
    for (NSURL *currentUrl in urls) {
        Music *currentMusic = [[Music alloc] initWithUrl:currentUrl];
        [musicsArray addObject:currentMusic];
        [currentMusic release];
    }
    
    return [musicsArray autorelease];
}

@end
