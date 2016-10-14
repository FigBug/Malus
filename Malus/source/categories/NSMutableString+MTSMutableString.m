//
//  NSMutableString+MTSMutableString.m
//  MTS
//
//  Created by Roland Rabien on 2013-09-11.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#import "NSMutableString+MTSMutableString.h"

@implementation NSMutableString (MTSMutableString)

- (void)setCharacter:(unichar)ch atIndex:(int)idx
{
    [self replaceCharactersInRange:NSMakeRange(idx, 1) withString:[NSString stringWithCharacters:&ch length:1]];
}

@end
