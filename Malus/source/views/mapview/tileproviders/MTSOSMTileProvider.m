//
//  MTSOSMTileProvider.m
//  MapKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MTSOSMTileProvider.h"
#import "MTSMapTypes.h"

@implementation MTSOSMTileProvider

- (NSURL *)tileURLForTile:(NSUInteger)x y:(NSUInteger)y zoomLevel:(NSUInteger)zoom
{
	NSString *url = [NSString stringWithFormat:@"http://tile.openstreetmap.org/%lu/%lu/%lu.png",
                     (unsigned long)zoom, (unsigned long)x, (unsigned long)y];
	
	return [NSURL URLWithString:url];
}

- (NSUInteger)minZoomLevel
{
	return 0;
}

- (NSUInteger)maxZoomLevel
{
	return 18;
}

- (CGSize)tileSize
{
	return CGSizeMake(256.0f, 256.0f);
}

- (NSString*)prefix
{
    return @"OSM";
}

@end
