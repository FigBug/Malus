//
//  MTSProjection.h
//  MapKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>

#import "MTSMapTypes.h"

@protocol MTSProjection <NSObject>

// Convert pixel coordinates to latitude / longitude and vice-versa

- (CGPoint)pointForCoordinate:(MTSMapCoordinate)coordinate zoomLevel:(NSUInteger)zoom tileSize:(CGSize)tileSize;
- (MTSMapCoordinate)coordinateForPoint:(CGPoint)point zoomLevel:(NSUInteger)zoom tileSize:(CGSize)tileSize;

@end
