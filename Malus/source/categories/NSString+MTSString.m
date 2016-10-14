//
//  NSMutableString+MTSString.m
//  MTS
//
//  Created by Roland Rabien on 2013-09-11.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#import "NSString+MTSString.h"

@implementation NSString (MTSString)

- (NSString*)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet*)characterSet
{
    NSUInteger length   = self.length;
    
    unichar charBuffer[length];
    [self getCharacters:charBuffer];

    NSUInteger location = 0;
    for (; location < length; location++)
    {
        if (![characterSet characterIsMember:charBuffer[location]])
            break;
    }
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

- (NSString*)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet*)characterSet
{
    NSUInteger length   = self.length;
    unichar charBuffer[length];
    [self getCharacters:charBuffer];

    NSUInteger location =0;
    for (; length > 0; length--)
    {
        if (![characterSet characterIsMember:charBuffer[length - 1]])
            break;
    }
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

- (NSString*)stringByTrimming
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString*)stringByTrimmingLeadingCharacters
{
    return [self stringByTrimmingLeadingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString*)stringByTrimmingTrailingCharacters
{
    return [self stringByTrimmingTrailingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
