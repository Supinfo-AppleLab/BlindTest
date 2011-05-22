//
//  NSMutableArray+RandomSort.m
//  BlindTest
//
//  Created by Adrien Brault on 19/05/11.
//  Copyright 2011 Adrien Brault. All rights reserved.
//

#import "NSMutableArray+RandomSort.h"


@implementation NSMutableArray (RandomSort)

- (void)shuffle
{
    for (NSInteger i=0; i<[self count]; i++) {
        NSInteger randomIndex = arc4random() % [self count];
        [self exchangeObjectAtIndex:i withObjectAtIndex:randomIndex];
    }
}

@end
