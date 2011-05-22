//
//  BlindTestAppDelegate.h
//  BlindTest
//
//  Created by Adrien Brault on 19/05/11.
//  Copyright 2011 Adrien Brault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlindTestAppDelegate : NSObject <UIApplicationDelegate> {
    UINavigationController *_navCon;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
