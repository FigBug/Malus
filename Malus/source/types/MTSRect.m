
//
//  MTSPoint.m
//
//  Created by Roland Rabien on 2013-08-27.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#import "MTSRect.h"

#if ! TARGET_OS_IPHONE
#import "NSValue+MTSValue.h"
#else
#import <UIKit/UIKit.h>
#endif

#define kVersion    @"version"
#define kRect       @"rect"

@implementation MTSRect

+ (MTSRect*)rectWithCGRect:(CGRect)rc
{
    return [[MTSRect alloc] initWithCGRect:rc];
}

+ (MTSRect*)rectWithCGPoint1:(CGPoint)p1 CGPoint2:(CGPoint)p2
{
    return [[MTSRect alloc] initWithCGPoint1:p1 CGPoint2:p2];
}

+ (MTSRect*)rectWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height
{
    return [[MTSRect alloc] initWithX:x y:y width:width height:height];
}

+ (MTSRect*)rectWithCenter:(CGPoint)center width:(CGFloat)width height:(CGFloat)height
{
    return [[MTSRect alloc] initWithCenter:center width:width height:height];
}

+ (MTSRect*)nullRect
{
    return [[MTSRect alloc] initWithCGRect:CGRectNull];
}

+ (MTSRect*)emptyRect
{
    return [[MTSRect alloc] init];
}

- (id)init
{
    return [self initWithCGRect:CGRectMake(0, 0, 0, 0)];
}

- (id)initWithCGRect:(CGRect)rc_
{
    self = [super init];
    if (self)
    {
        rc = CGRectStandardize(rc_);
    }
    return self;
}

- (id)initWithCGPoint1:(CGPoint)p1 CGPoint2:(CGPoint)p2
{
    return [self initWithCGRect:CGRectMake(p1.x, p1.y, p2.x - p1.x, p2.y - p1.y)];
}

- (id)initWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height
{
    return [self initWithCGRect:CGRectMake(x, y, width, height)];
}

- (id)initWithCenter:(CGPoint)center width:(CGFloat)width height:(CGFloat)height
{
    return [self initWithCGRect:CGRectMake(center.x - width / 2, center.y - height / 2, width, height)];
}

- (BOOL)isNull
{
    return CGRectIsNull(rc);
}

- (BOOL)isEmpty
{
    return CGRectIsEmpty(rc);
}

- (BOOL)isInfinite
{
    return CGRectIsInfinite(rc);
}

- (CGFloat)x
{
    return rc.origin.x;
}

- (void)setX:(CGFloat)x
{
    rc.origin.x = x;
}

- (CGFloat)y
{
    return rc.origin.y;
}

- (void)setY:(CGFloat)y
{
    rc.origin.y = y;
}

- (CGFloat)width
{
    return rc.size.width;
}

- (void)setWidth:(CGFloat)width
{
    rc.size.width = width;
    rc = CGRectStandardize(rc);
}

- (CGFloat)height
{
    return rc.size.height;
}

- (void)setHeight:(CGFloat)height
{
    rc.size.height = height;
    rc = CGRectStandardize(rc);
}

- (CGRect)CGRect
{
    return rc;
}

- (void)setCGRect:(CGRect)rc_
{
    rc = CGRectStandardize(rc_);
}

- (MTSPoint*)topLeft
{
    return [MTSPoint pointWithX:self.left y:self.top];
}

- (MTSPoint*)topRight
{
    return [MTSPoint pointWithX:self.right y:self.top];
}

- (MTSPoint*)bottomLeft
{
    return [MTSPoint pointWithX:self.left y:self.bottom];
}

- (MTSPoint*)bottomRight
{
    return [MTSPoint pointWithX:self.right y:self.bottom];
}

- (CGFloat)left
{
    return rc.origin.x;
}

- (CGFloat)top
{
    return rc.origin.y;
}

- (CGFloat)right
{
    return rc.origin.x + rc.size.width;
}

- (CGFloat)bottom
{
    return rc.origin.y + rc.size.height;
}

- (MTSRect*)intersctionWith:(MTSRect*)other
{
    return [MTSRect rectWithCGRect:CGRectIntersection(rc, other.CGRect)];
}

- (MTSRect*)unionWith:(MTSRect*)other
{
    return [MTSRect rectWithCGRect:CGRectUnion(rc, other.CGRect)];
}

- (MTSRect*)insetX:(CGFloat)dx y:(CGFloat)dy
{
    return [MTSRect rectWithCGRect:CGRectInset(rc, dx, dy)];
}

- (BOOL)containsPoint:(MTSPoint*)pt
{
    return CGRectContainsPoint(rc, pt.CGPoint);
}

- (MTSPoint*)centerPoint
{
    return [MTSPoint pointWithX:CGRectGetMinX(rc) y:CGRectGetMidY(rc)];
}

- (CGFloat)xAtPercent:(CGFloat)percent
{
    return rc.origin.x + rc.size.width * percent;
}

- (CGFloat)yAtPercent:(CGFloat)percent
{
    return rc.origin.y + rc.size.height * percent;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[MTSRect class]])
    {
        MTSRect* other = (MTSRect*)object;
        return CGRectEqualToRect(rc, other->rc);
    }
    return NO;
}

- (NSUInteger)hash
{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    
    result = prime * result + [[NSNumber numberWithDouble:rc.origin.x] hash];
    result = prime * result + [[NSNumber numberWithDouble:rc.origin.y] hash];
    result = prime * result + [[NSNumber numberWithDouble:rc.size.width] hash];
    result = prime * result + [[NSNumber numberWithDouble:rc.size.height] hash];

    return result;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%f %f %f %f", rc.origin.x, rc.origin.y, rc.size.width, rc.size.height];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    MTSRect* rect = [[[self class] allocWithZone:zone] init];
    rect->rc = rc;
    return rect;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder*)decoder
{
    self = [super init];
    if (self)
    {
        NSValue* value = [decoder decodeObjectForKey:kRect];
        rc = value ? [value CGRectValue] : CGRectMake(0, 0, 0, 0);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeInt:1 forKey:kVersion];
    [encoder encodeObject:[NSValue valueWithCGRect:rc] forKey:kRect];
}

- (MTSRect*)rectRemovedFromTop:(CGFloat)h
{
    MTSRect* r = [[MTSRect alloc] initWithX:self.x y:self.y width:self.width height:fmin (h, self.height)];
    self.y += r.height;
    self.height -= r.height;
    return r;
}

- (MTSRect*)rectRemovedFromBottom:(CGFloat)h
{
    h = fmin (h, self.height);
    MTSRect* r = [[MTSRect alloc] initWithX:self.x y:self.y + self.height - h width:self.width height:h];
    self.height -= h;
    return r;
}

- (MTSRect*)rectRemovedFromLeft:(CGFloat)w
{
    MTSRect* r = [[MTSRect alloc] initWithX:self.x y:self.y width:fmin (self.width, w) height:self.height];
    self.x += r.width;
    self.width -= r.width;
    return r;
}

- (MTSRect*)rectRemovedFromRight:(CGFloat)w
{
    w = fmin (w, self.width);
    MTSRect* r = [[MTSRect alloc] initWithX:self.x + self.width - w y:self.y width:w height:self.height];
    self.width -= w;
    return r;
}

- (MTSRect*)reduced:(CGFloat)xy
{
    return [self reducedX:xy y:xy];
}

- (MTSRect*)reducedX:(CGFloat)x y:(CGFloat)y
{
    x = fmin (x, self.width / 2);
    y = fmin (y, self.height / 2);
    return [[MTSRect alloc] initWithX:self.x + x y:self.y + y
                                width:self.width - x * 2 height:self.height - y * 2];
}


@end
