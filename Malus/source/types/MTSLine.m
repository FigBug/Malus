//
//  MTSLine.m
//  MTS
//
//  Created by Roland Rabien on 2013-09-05.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#import "MTSLine.h"

#if ! TARGET_OS_IPHONE
#import "NSValue+MTSValue.h"
#else
#import <UIKit/UIKit.h>
#endif

#define kVersion    @"version"
#define kPoint1     @"point1"
#define kPoint2     @"point2"

@implementation MTSLine

- (id)init
{
    return [self initFrom:[MTSPoint pointWithX:0 y:0] to:[MTSPoint pointWithX:0 y:0]];
}

- (id)initFrom:(MTSPoint*)pt1_ to:(MTSPoint*)pt2_
{
    self = [super init];
    if (self)
    {
        pt1 = pt1_.CGPoint;
        pt2 = pt2_.CGPoint;
    }
    return self;
}

- (double)length
{
    return sqrt(self.dx*self.dx + self.dy+self.dy);
}

- (MTSPoint*)pt1
{
    return [MTSPoint pointWithCGPoint:pt1];
}

- (MTSPoint*)pt2
{
    return [MTSPoint pointWithCGPoint:pt2];
}

- (double)angle
{
    return atan2(self.dx, self.dy);
}

- (double)dx
{
    return pt2.x - pt1.x;
}

- (double)dy
{
    return pt2.y - pt1.y;
}

- (BOOL)solveForM:(double*)m b:(double*)b
{
    if (pt1.x != pt2.x)
    {
        *m = (pt2.y - pt1.y) / (pt2.x - pt1.x);
        *b = pt2.y - *m * pt2.x;
        
        return YES;
    }
    else
    {
        *m = 0;
        *b = 0;
        
        return NO;
    }
}

- (double)xAtY:(double)y
{
    double m;
    double b;
    if ([self solveForM:&m b:&b])
        return (y - b) / m;
    else
        return pt1.x;
}

- (double)yAtX:(double)x
{
    double m;
    double b;
    if ([self solveForM:&m b:&b])
        return m * x + b;
    else
        return 0;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[MTSLine class]])
    {
        MTSLine* other = (MTSLine*)object;
        return CGPointEqualToPoint(pt1, other->pt1) && CGPointEqualToPoint(pt2, other->pt2);
    }
    return NO;
}

- (NSUInteger)hash
{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    
    result = prime * result + [[NSNumber numberWithDouble:pt1.x] hash];
    result = prime * result + [[NSNumber numberWithDouble:pt1.y] hash];
    result = prime * result + [[NSNumber numberWithDouble:pt2.x] hash];
    result = prime * result + [[NSNumber numberWithDouble:pt2.y] hash];
    
    return result;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"(%f,%f) (%f,%f)", pt1.x, pt1.y, pt2.x, pt2.y];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    MTSLine* point = [[[self class] allocWithZone:zone] init];
    point->pt1 = pt1;
    point->pt2 = pt2;
    return point;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder*)decoder
{
    self = [super init];
    if (self)
    {
        NSValue* value;
        
        value = [decoder decodeObjectForKey:kPoint1];
        pt1 = value ? [value CGPointValue] : CGPointMake(0, 0);
        
        value = [decoder decodeObjectForKey:kPoint2];
        pt2 = value ? [value CGPointValue] : CGPointMake(0, 0);

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeInt:1 forKey:kVersion];
    [encoder encodeObject:[NSValue valueWithCGPoint:pt1] forKey:kPoint1];
    [encoder encodeObject:[NSValue valueWithCGPoint:pt2] forKey:kPoint2];
}

@end
