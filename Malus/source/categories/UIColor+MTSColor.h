//
//  UIColor+MTSColor.h
//
//  Created by Roland Rabien on 2012-10-26.
//  Copyright (c) 2012 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

@interface UIColor (MTSColor)

+ (UIColor*)goldenRatioColor:(int)idx;
+ (UIColor*)uniqueColor:(int)idx;
+ (UIColor*)randomColor;

+ (UIColor*)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;
- (UIColor*)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;

- (BOOL)getHue:(CGFloat*)hue saturation:(CGFloat*)saturation lightness:(CGFloat*)lightness alpha:(CGFloat*)alpha;

- (UIColor*)lightenColorBy:(float)value;
- (UIColor*)darkenColorBy:(float)value;

- (BOOL)isLightColor;

@end
#endif