
//
//  MTSPoint.m
//
//  Created by Roland Rabien on 2013-08-27.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#import "MTSPoint.h"

#if ! TARGET_OS_IPHONE
#import "NSValue+MTSValue.h"
#else
#import <UIKit/UIKit.h>
#endif

#define kVersion    @"version"
#define kPoint      @"point"

@implementation MTSPoint

+ (MTSPoint*)pointWithCGPoint:(CGPoint)pt
{
    return [[MTSPoint alloc] initWithCGPoint:pt];
}

+ (MTSPoint*)pointWithX:(CGFloat)x y:(CGFloat)y
{
    return [[MTSPoint alloc] initWithCGPoint:CGPointMake(x, y)];
}

- (id)init
{
    return [self initWithCGPoint:CGPointMake(0, 0)];
}

- (id)initWithCGPoint:(CGPoint)pt_
{
    self = [super init];
    if (self)
    {
        pt = pt_;
    }
    return self;
}

- (id)initWithX:(CGFloat)x y:(CGFloat)y
{
    return [self initWithCGPoint:CGPointMake(x, y)];
}

- (CGFloat)x
{
    return pt.x;
}

- (void)setX:(CGFloat)x
{
    pt.x = x;
}

- (CGFloat)y
{
    return pt.y;
}

- (void)setY:(CGFloat)y
{
    pt.y = y;
}

- (CGPoint)CGPoint
{
    return pt;
}

- (void)setCGPoint:(CGPoint)pt_
{
    pt = pt_;
}

- (void)translateX:(CGFloat)x y:(CGFloat)y
{
    pt.x += x;
    pt.y += y;
}

- (MTSPoint*)pointByTranslatingX:(CGFloat)x y:(CGFloat)y
{
    return [[MTSPoint alloc] initWithCGPoint:CGPointMake(x, y)];
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[MTSPoint class]])
    {
        MTSPoint* other = (MTSPoint*)object;
        return CGPointEqualToPoint(pt, other->pt);
    }
    return NO;
}

- (NSUInteger)hash
{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    
    result = prime * result + [[NSNumber numberWithDouble:pt.x] hash];
    result = prime * result + [[NSNumber numberWithDouble:pt.y] hash];
    
    return result;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%f %f", pt.x, pt.y];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    MTSPoint* point = [[[self class] allocWithZone:zone] init];
    point->pt = pt;
    return point;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder*)decoder
{
    self = [super init];
    if (self)
    {
        NSValue* value = [decoder decodeObjectForKey:kPoint];
        pt = value ? [value CGPointValue] : CGPointMake(0, 0);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeInt:1 forKey:kVersion];
    [encoder encodeObject:[NSValue valueWithCGPoint:pt] forKey:kPoint];
}

@end
