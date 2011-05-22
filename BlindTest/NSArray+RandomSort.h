//
//  NSArray+RandomSort.h
//  BlindTest
//
//  Created by Adrien Brault on 20/05/11.
//  Copyright 2011 Adrien Brault. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (RandomSort)

- (NSMutableArray *)shuffledMutableCopy;
- (NSArray *)shuffledCopy;

@end
