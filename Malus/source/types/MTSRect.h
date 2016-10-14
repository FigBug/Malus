//
//  MTSRect.h
//
//  Created by Roland Rabien on 2013-08-27.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>

#import "MTSPoint.h"

@interface MTSRect : NSObject<NSCopying,NSCoding> {
    CGRect rc;
}

+ (MTSRect*)rectWithCGRect:(CGRect)rc;
+ (MTSRect*)rectWithCGPoint1:(CGPoint)p1 CGPoint2:(CGPoint)p2;
+ (MTSRect*)rectWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;
+ (MTSRect*)rectWithCenter:(CGPoint)center width:(CGFloat)width height:(CGFloat)height;
+ (MTSRect*)nullRect;
+ (MTSRect*)emptyRect;

- (id)init;
- (id)initWithCGRect:(CGRect)rc;
- (id)initWithCGPoint1:(CGPoint)p1 CGPoint2:(CGPoint)p2;
- (id)initWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;
- (id)initWithCenter:(CGPoint)center width:(CGFloat)width height:(CGFloat)height;

- (BOOL)isNull;
- (BOOL)isEmpty;
- (BOOL)isInfinite;

- (CGFloat)x;
- (void)setX:(CGFloat)x;

- (CGFloat)y;
- (void)setY:(CGFloat)y;

- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

- (CGRect)CGRect;
- (void)setCGRect:(CGRect)rc;

- (MTSPoint*)topLeft;
- (MTSPoint*)topRight;
- (MTSPoint*)bottomLeft;
- (MTSPoint*)bottomRight;

- (CGFloat)left;
- (CGFloat)top;
- (CGFloat)right;
- (CGFloat)bottom;

- (MTSRect*)intersctionWith:(MTSRect*)other;
- (MTSRect*)unionWith:(MTSRect*)other;

- (MTSRect*)insetX:(CGFloat)dx y:(CGFloat)dy;

- (BOOL)containsPoint:(MTSPoint*)pt;
- (MTSPoint*)centerPoint;

- (CGFloat)xAtPercent:(CGFloat)percent;
- (CGFloat)yAtPercent:(CGFloat)percent;

- (MTSRect*)rectRemovedFromTop:(CGFloat)h;
- (MTSRect*)rectRemovedFromBottom:(CGFloat)h;
- (MTSRect*)rectRemovedFromLeft:(CGFloat)w;
- (MTSRect*)rectRemovedFromRight:(CGFloat)w;

- (MTSRect*)reduced:(CGFloat)xy;
- (MTSRect*)reducedX:(CGFloat)x y:(CGFloat)y;


@end