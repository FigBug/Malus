//
//  MTSMercatorProjection.m
//  MapKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MTSMercatorProjection.h"

@implementation MTSMercatorProjection

- (CGPoint)pointForCoordinate:(MTSMapCoordinate)coordinate zoomLevel:(NSUInteger)zoom tileSize:(CGSize)tileSize {
	
	double sinLatitude = sin(coordinate.latitude * M_PI / 180);
	CGFloat y = ((0.5 - log((1 + sinLatitude) / (1 - sinLatitude)) / (4 * M_PI)) * ((long) tileSize.height << zoom));
	CGFloat x = ((coordinate.longitude + 180) / 360 * ((long) tileSize.width << zoom));
	
	return CGPointMake(x, y);
}

- (MTSMapCoordinate)coordinateForPoint:(CGPoint)point zoomLevel:(NSUInteger)zoom tileSize:(CGSize)tileSize {
	
	MTSLongitude lon = 360 * ((point.x / ((long) tileSize.width << zoom)) - 0.5);
	
	double y = 0.5 - (point.y / ((long) tileSize.height << zoom));
	MTSLatitude lat = 90 - 360 * atan(exp(-y * 2 * M_PI)) / M_PI;
	
	return MTSMapCoordinateMake(lat, lon);
}

@end
