//
//  NSValue+MTSValue.m
//  Malus
//
//  Created by Roland Rabien on 2016-01-24.
//  Copyright © 2016 Roland Rabien Design. All rights reserved.
//
#import <Foundation/Foundation.h>
#if ! TARGET_OS_IPHONE
#import "NSValue+MTSValue.h"

@implementation NSValue (MTSValue)

- (CGRect)CGRectValue
{
    return NSRectToCGRect([self rectValue]);
}

+ (NSValue*)valueWithCGRect:(CGRect)rc
{
    return [NSValue valueWithRect:NSRectFromCGRect(rc)];
}

- (CGPoint)CGPointValue
{
    return NSPointToCGPoint([self pointValue]);
}

+ (NSValue*)valueWithCGPoint:(CGPoint)p
{
    return [NSValue valueWithPoint:NSPointFromCGPoint(p)];
}

@end
#endif