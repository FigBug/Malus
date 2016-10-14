//
//  MTSMapTypes.m
//  MapKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MTSMapTypes.h"

MTSMapCoordinate MTSMapCoordinateMake (MTSLatitude lat, MTSLongitude lng)
{
	return (MTSMapCoordinate) { .latitude = lat, .longitude = lng };
}

NSUInteger MTSMapZoomLevelFromScale (NSUInteger scale)
{
	return log2(scale);
}

NSUInteger MTSMapScaleFromZoomLevel (NSUInteger zoomLevel)
{
	return pow(2, zoomLevel);
}
