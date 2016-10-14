//
//  MTSTileProvider.h
//  MapKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>

@protocol MTSTileProvider <NSObject>

- (NSURL*)tileURLForTile:(NSUInteger)x y:(NSUInteger)y zoomLevel:(NSUInteger)zoom;

- (NSUInteger)minZoomLevel;
- (NSUInteger)maxZoomLevel;

- (CGSize)tileSize;

- (NSString*)prefix;

@end
