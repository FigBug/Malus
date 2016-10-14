//
//  NSArray+MTSArray.m
//
//  Created by Roland Rabien on 2012-10-03.
//  Copyright (c) 2012 Roland Rabien. All rights reserved.
//

#import "NSArray+MTSArray.h"

@implementation NSArray (MTSArray)

- (id)firstObject
{
    if ([self count] > 0)
    {
        return [self objectAtIndex:0];
    }
    return nil;
}

@end
