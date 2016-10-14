//
//  MRMapTypes.h
//  MapKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef double MTSLatitude;
typedef double MTSLongitude;

struct _MTSMapCoordinate
{
	MTSLatitude latitude;
	MTSLongitude longitude;
};

typedef struct _MTSMapCoordinate MTSMapCoordinate;

MTSMapCoordinate MTSMapCoordinateMake (MTSLatitude lat, MTSLongitude lng);

// Convert between map scales and zoom levels
NSUInteger MTSMapZoomLevelFromScale(NSUInteger scale);
NSUInteger MTSMapScaleFromZoomLevel(NSUInteger zoomLevel);
