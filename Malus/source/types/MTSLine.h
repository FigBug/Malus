//
//  MTSLine.h
//  MTS
//
//  Created by Roland Rabien on 2013-09-05.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>

#import <Malus/MTSPoint.h>

@interface MTSLine : NSObject<NSCopying,NSCoding> {
    CGPoint pt1;
    CGPoint pt2;
}

- (id)initFrom:(MTSPoint*)pt1 to:(MTSPoint*)pt2;

- (double)length;

- (MTSPoint*)pt1;
- (MTSPoint*)pt2;

- (double)angle;

- (double)dx;
- (double)dy;

- (BOOL)solveForM:(double*)m b:(double*)b;

- (double)xAtY:(double)y;
- (double)yAtX:(double)x;

@end
