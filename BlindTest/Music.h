//
//  Music.h
//  BlindTest
//
//  Created by Adrien Brault on 19/05/11.
//  Copyright 2011 Adrien Brault. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
    This class represents a MP3.
*/

@interface Music : NSObject {
    NSURL *_url;
    NSString *_title;
    NSString *_artist;
    CGFloat _duration;
}

@property (nonatomic, readonly) NSURL *url;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *artist;
@property (nonatomic, readonly) CGFloat duration;

- (id)initWithUrl:(NSURL *)url;

+ (NSArray *)loadMusicsFromBundle;

@end
