//
//  UIColor+MTSColor.m
//
//  Created by Roland Rabien on 2012-10-26.
//  Copyright (c) 2012 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "UIColor+MTSColor.h"

#define ARC4RANDOM_MAX      0x100000000

static void hsv_to_hsl(CGFloat h, CGFloat s, CGFloat v, CGFloat* hh, CGFloat* ss, CGFloat *ll)
{
    *hh = h;
    *ll = (2 - s) * v;
    *ss = s * v;
    *ss /= (*ll <= 1) ? (*ll) : 2 - (*ll);
    *ll /= 2;
}

static void hsl_to_hsv(CGFloat hh, CGFloat ss, CGFloat ll, CGFloat* h, CGFloat* s, CGFloat *v)
{
    *h = hh;
    ll *= 2;
    ss *= (ll <= 1) ? ll : 2 - ll;
    *v = (ll + ss) / 2;
    *s = (2 * ss) / (ll + ss);
}

@implementation UIColor (MTSColor)

+ (UIColor*)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha
{
    return [[UIColor alloc] initWithHue:hue saturation:saturation lightness:lightness alpha:alpha];
}

- (UIColor*)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha
{
    CGFloat h = 0;
    CGFloat s = 0;
    CGFloat v = 0;
    hsl_to_hsv(hue, saturation, lightness, &h, &s, &v);
    return [self initWithHue:h saturation:s brightness:v alpha:alpha];
}

- (BOOL)getHue:(CGFloat*)hue saturation:(CGFloat*)saturation lightness:(CGFloat*)lightness alpha:(CGFloat*)alpha
{
    CGFloat h;
    CGFloat s;
    CGFloat v;
    
    if ([self getHue:&h saturation:&s brightness:&v alpha:alpha])
    {
        hsv_to_hsl(h, s, v, hue, saturation, lightness);
        return YES;
    }
    else
    {
        return NO;
    }
}

- (UIColor*)lightenColorBy:(float)value
{
    int   totalComponents = (int)CGColorGetNumberOfComponents(self.CGColor);
    bool  isGreyscale     = totalComponents == 2 ? YES : NO;
    
    CGFloat* oldComponents = (CGFloat *)CGColorGetComponents(self.CGColor);
    CGFloat newComponents[4];
    
    if (isGreyscale)
    {
        newComponents[0] = oldComponents[0]+value > 1.0 ? 1.0 : oldComponents[0]+value;
        newComponents[1] = oldComponents[0]+value > 1.0 ? 1.0 : oldComponents[0]+value;
        newComponents[2] = oldComponents[0]+value > 1.0 ? 1.0 : oldComponents[0]+value;
        newComponents[3] = oldComponents[1];
    }
    else
    {
        newComponents[0] = oldComponents[0]+value > 1.0 ? 1.0 : oldComponents[0]+value;
        newComponents[1] = oldComponents[1]+value > 1.0 ? 1.0 : oldComponents[1]+value;
        newComponents[2] = oldComponents[2]+value > 1.0 ? 1.0 : oldComponents[2]+value;
        newComponents[3] = oldComponents[3];
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor* retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
    return retColor;
}

- (UIColor*)darkenColorBy:(float)value
{
    int   totalComponents = (int)CGColorGetNumberOfComponents(self.CGColor);
    bool  isGreyscale     = totalComponents == 2 ? YES : NO;
    
    CGFloat* oldComponents = (CGFloat *)CGColorGetComponents(self.CGColor);
    CGFloat newComponents[4];
    
    if (isGreyscale)
    {
        newComponents[0] = oldComponents[0]-value < 0.0 ? 0.0 : oldComponents[0]-value;
        newComponents[1] = oldComponents[0]-value < 0.0 ? 0.0 : oldComponents[0]-value;
        newComponents[2] = oldComponents[0]-value < 0.0 ? 0.0 : oldComponents[0]-value;
        newComponents[3] = oldComponents[1];
    }
    else
    {
        newComponents[0] = oldComponents[0]-value < 0.0 ? 0.0 : oldComponents[0]-value;
        newComponents[1] = oldComponents[1]-value < 0.0 ? 0.0 : oldComponents[1]-value;
        newComponents[2] = oldComponents[2]-value < 0.0 ? 0.0 : oldComponents[2]-value;
        newComponents[3] = oldComponents[3];
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor* retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
    return retColor;
}

- (BOOL)isLightColor
{
    int   totalComponents = (int)CGColorGetNumberOfComponents(self.CGColor);
    bool  isGreyscale     = totalComponents == 2 ? YES : NO;
    
    CGFloat* components = (CGFloat *)CGColorGetComponents(self.CGColor);
    CGFloat sum;
    
    if (isGreyscale)
    {
        sum = components[0];
    }
    else
    {
        sum = (components[0]+components[1]+components[2])/3.0;
    }
    
    return (sum > 0.8);
}

+ (UIColor*)goldenRatioColor:(int)idx
{
    double h = fmod(idx * 0.618033988749895, 1);
    return [UIColor colorWithHue:h saturation:0.8 brightness:0.95 alpha:1.0];
}


+ (UIColor*)uniqueColor:(int)idx
{
    NSMutableArray* wheel = [[NSMutableArray alloc] init];
    double pos = 0;
    
    while (YES)
    {
        if (wheel.count == 0)
        {
            [wheel addObject:@0.0];
            [wheel addObject:@1.0];
        }
        else
        {
            double gap = 0;
            double hi = 0;
            double lo = 0;
            
            for (int i = 0; i < wheel.count - 1; i++)
            {
                double g = [wheel[i + 1] doubleValue] - [wheel[i] doubleValue];
                if (g > gap && (wheel.count < 6 || fabs(pos - (g / 2.0 + [wheel[i] doubleValue])) > 0.4))
                {
                    gap = g;
                    lo = [wheel[i] doubleValue];
                    hi = [wheel[i + 1] doubleValue];
                }
            }
            
            pos = (hi - lo) / 2.0 + lo;
            
            [wheel addObject:[NSNumber numberWithDouble:pos]];
            [wheel sortUsingSelector:@selector(compare:)];
        }
        if (idx < (wheel.count - 1))
        {
            return [UIColor colorWithHue:pos saturation:0.94 brightness:0.47 alpha:1.0];
        }
    }
}

+ (UIColor*)randomColor
{
    return [UIColor colorWithRed:(double)arc4random() / ARC4RANDOM_MAX
                           green:(double)arc4random() / ARC4RANDOM_MAX
                            blue:(double)arc4random() / ARC4RANDOM_MAX
                           alpha:1.0];
}

@end
#endif