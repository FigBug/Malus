//
//  MTSTextItem.m
//
//  Created by Roland Rabien on 2013-08-27.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "MTSTextItem.h"
#import "NSObject+MTSCast.h"

@implementation MTSTextItem

@synthesize text;
@synthesize color;
@synthesize strokeColor;

- (BOOL)isEqual:(id)object
{
    MTSTextItem* other = [MTSTextItem cast:object];
    
    return other                                    &&
           [text isEqual:other.text]                &&
           [color isEqual:other.color]              &&
           [strokeColor isEqual:other.strokeColor];
}

@end
#endif