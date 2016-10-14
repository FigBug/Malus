//
//  MTSPoint.h
//
//  Created by Roland Rabien on 2013-08-27.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>

@interface MTSPoint : NSObject<NSCopying,NSCoding> {
    CGPoint pt;
}

+ (MTSPoint*)pointWithCGPoint:(CGPoint)pt;
+ (MTSPoint*)pointWithX:(CGFloat)x y:(CGFloat)y;

- (id)init;
- (id)initWithCGPoint:(CGPoint)pt;
- (id)initWithX:(CGFloat)x y:(CGFloat)y;

- (CGFloat)x;
- (void)setX:(CGFloat)x;

- (CGFloat)y;
- (void)setY:(CGFloat)y;

- (CGPoint)CGPoint;
- (void)setCGPoint:(CGPoint)pt;

- (void)translateX:(CGFloat)x y:(CGFloat)y;
- (MTSPoint*)pointByTranslatingX:(CGFloat)x y:(CGFloat)y;

@end
