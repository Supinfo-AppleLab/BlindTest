//
//  NSArray+RandomSort.m
//  BlindTest
//
//  Created by Adrien Brault on 20/05/11.
//  Copyright 2011 Adrien Brault. All rights reserved.
//

#import "NSArray+RandomSort.h"
#import "NSMutableArray+RandomSort.h"

@implementation NSArray (RandomSort)

- (NSMutableArray *)shuffledMutableCopy
{
    NSMutableArray *copy = [self mutableCopy];
    [copy shuffle];
    return copy;
}

- (NSArray *)shuffledCopy
{
    return [self shuffledMutableCopy];
}

@end
