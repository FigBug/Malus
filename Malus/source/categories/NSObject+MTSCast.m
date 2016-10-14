//
//  NSObject+MTSCast.m
//
//  Created by Roland Rabien on 2013-04-12.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "NSObject+MTSCast.h"

@implementation NSObject (MTSCast)

+ (instancetype)cast:(id)from
{
    if ([from isKindOfClass:self])
    {
        return from;
    }
    return nil;
}

@end
