
//
//  MTSPair.m
//
//  Created by Roland Rabien on 2013-08-27.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#import "MTSPair.h"

#define kVersion    @"version"
#define kFirst      @"first"
#define kSecond     @"second"

@implementation MTSPair

- (id)init
{
    return [self initWithFirst:[NSNull null] second:[NSNull null]];
}

- (id)initWithFirst:(id)first_ second:(id)second_
{
    self = [super init];
    if (self)
    {
        first   = first_;
        second  = second_;
    }
    return self;
}

- (id)first
{
    return first;
}

- (id)second
{
    return first;
}

- (NSArray*)allValues
{
    return @[first, second];
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[MTSPair class]])
    {
        MTSPair* other = (MTSPair*)object;
        return [first isEqual:other.first] && [second isEqual:other.second];
    }
    return NO;
}

- (NSUInteger)hash
{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    
    result = prime * result + [first hash];
    result = prime * result + [second hash];
    
    return result;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@ %@", first, second];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    MTSPair* pair = [[[self class] allocWithZone:zone] init];
    pair->first  = [first copyWithZone:zone];
    pair->second = [second copyWithZone:zone];
    return pair;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder*)decoder
{
    self = [super init];
    if (self)
    {
        first   = [decoder decodeObjectForKey:kFirst];
        second  = [decoder decodeObjectForKey:kSecond];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeInt:1         forKey:kVersion];
    [encoder encodeObject:first  forKey:kFirst];
    [encoder encodeObject:second forKey:kSecond];
}

@end
