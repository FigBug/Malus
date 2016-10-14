//
//  UIView+MTSRect.m
//  LibMTS
//
//  Created by Roland Rabien on 2013-09-03.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "UIView+MTSRect.h"

@implementation UIView (MTSRect)

- (MTSRect*)boundsRect
{
    return [MTSRect rectWithCGRect:self.bounds];
}

- (void)setBoundsRect:(MTSRect*)rect
{
    self.bounds = rect.CGRect;
}

- (MTSRect*)frameRect
{
    return [MTSRect rectWithCGRect:self.frame];
}

- (void)setFrameRect:(MTSRect*)rect
{
    self.frame = rect.CGRect;
}

@end
#endif