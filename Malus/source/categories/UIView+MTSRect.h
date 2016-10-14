//
//  UIView+MTSRect.h
//  LibMTS
//
//  Created by Roland Rabien on 2013-09-03.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

#import <Malus/MTSRect.h>

@interface UIView (MTSRect)

- (MTSRect*)boundsRect;
- (void)setBoundsRect:(MTSRect*)rect;

- (MTSRect*)frameRect;
- (void)setFrameRect:(MTSRect*)rect;

@end
#endif