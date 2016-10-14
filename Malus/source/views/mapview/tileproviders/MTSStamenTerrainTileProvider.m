//
//  MTSOpenCycleMapTileProvider.m
//
//  Copyright Roland Rabien 2013. All rights reserved.
//

#import "MTSStamenTerrainTileProvider.h"
#import "MTSMapTypes.h"

@implementation MTSStamenTerrainTileProvider

- (NSURL *)tileURLForTile:(NSUInteger)x y:(NSUInteger)y zoomLevel:(NSUInteger)zoom
{
	NSString *url = [NSString stringWithFormat:@"http://tile.stamen.com/terrain/%lu/%lu/%lu.png",
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
    return @"StamenT";
}

@end
