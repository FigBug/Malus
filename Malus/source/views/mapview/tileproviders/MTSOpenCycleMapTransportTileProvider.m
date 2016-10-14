//
//  MTSOpenCycleMapTileProvider.m
//
//  Copyright Roland Rabien 2013. All rights reserved.
//

#import "MTSOpenCycleMapTransportTileProvider.h"
#import "MTSMapTypes.h"

@implementation MTSOpenCycleMapTransportTileProvider

- (NSURL *)tileURLForTile:(NSUInteger)x y:(NSUInteger)y zoomLevel:(NSUInteger)zoom
{
	NSString *url = [NSString stringWithFormat:@"http://a.tile.opencyclemap.org/transport/%lu/%lu/%lu.png",
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
    return @"OCM-T";
}

@end
