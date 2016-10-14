
//
//  MTSMapBaseView.m
//  Util
//
//  Created by Roland Rabien on 2013-08-05.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "MTSMapBaseView.h"
#import "MTSMapTypes.h"
#import "MTSMapPath.h"

#define DEG_CIRCLE 360
#define DEG_TO_RAD (M_PI / (DEG_CIRCLE / 2))
#define RAD_TO_DEG ((DEG_CIRCLE / 2) / M_PI)

double deg2rad(double degrees)
{
    return degrees * DEG_TO_RAD;
}

@implementation MTSMapBaseView

@synthesize mapPaths;

static NSString* const kLastFlushedKey = @"lastFlushedTileCache";

#define kDay 60 * 60 * 24

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
    {
        mapPaths = [[NSMutableArray alloc] init];
        
		cache = [[MTSTileCache alloc] initWithCacheDirectory:[self cacheDirectory]];
		
		NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
		NSDate* date = [defs valueForKey:kLastFlushedKey];
		
		if (!date || -[date timeIntervalSinceNow] > kDay)
        {
			[cache flushOldCaches];
			
			[defs setValue:[NSDate date] forKey:kLastFlushedKey];
			[defs synchronize];
		}
	}
	return self;
}

- (NSString*)cacheDirectory
{
	NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	
	if (![dirs count])
		return nil;
	
	NSString* path = [[dirs objectAtIndex:0] stringByAppendingPathComponent:@"Tiles"];
	
	NSFileManager* fm = [[NSFileManager alloc] init];
	
	if (![fm fileExistsAtPath:path isDirectory:NULL])
    {
		[fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
	}
	
	return path;
}

+ (Class)layerClass
{
	return [CATiledLayer class];
}

- (void)configureLayer
{
	CATiledLayer* tiledLayer = (CATiledLayer*)self.layer;
	tiledLayer.levelsOfDetail = [tileProvider maxZoomLevel];
	tiledLayer.levelsOfDetailBias = [tileProvider maxZoomLevel];
	
	CGSize tileSize = [tileProvider tileSize];
	tiledLayer.tileSize = tileSize;
	tiledLayer.frame = CGRectMake(0.0f, 0.0f, tileSize.width, tileSize.height);
	
	[self.layer setNeedsDisplay];
}

- (id<MTSTileProvider>)tileProvider
{
    return tileProvider;
}

- (void)setTileProvider:(id<MTSTileProvider>)prov
{
	if (tileProvider != prov)
    {
		tileProvider = prov;
		
		[self configureLayer];
	}
}

-(CGPoint)mapWorldToView:(CGPoint)worldPt
{
    CGRect crect  =  self.bounds;

    CGPoint viewPt;

    viewPt.x = (worldPt.x + 180.0) / 360.0 * crect.size.width;
    viewPt.y = (1 - (log(tan(M_PI / 4 + deg2rad(worldPt.y) / 2)) / M_PI)) / 2  * crect.size.height;

    return viewPt;
}

- (void)drawRect:(CGRect)rect
{
	if (!tileProvider)
		return;
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
    [self drawTilesOn:ctx];
    
    for (MTSMapPath* path in mapPaths)
        [self drawPath:path on:ctx];
}

- (void)drawPath:(MTSMapPath*)path on:(CGContextRef)ctx
{
    CGContextBeginPath(ctx);
    CGContextSetLineWidth(ctx, 0.00005);
    
    CGContextSetStrokeColorWithColor(ctx, path.color.CGColor);
    
    bool first = true;
    for (NSValue* value in path.points)
    {
        CGPoint worldPt = [value CGPointValue];
        CGPoint viewPt  = [self mapWorldToView:worldPt];
        
        if (first)
        {
            CGContextMoveToPoint(ctx, viewPt.x, viewPt.y);
            first = false;
        }
        else
        {
            CGContextAddLineToPoint(ctx, viewPt.x, viewPt.y);
        }
    }
    
    CGContextStrokePath(ctx);
}

- (void)drawTilesOn:(CGContextRef)ctx
{
	CGRect crect  = CGContextGetClipBoundingBox(ctx);
	CGFloat scale = CGContextGetCTM(ctx).a;
    
	NSUInteger zoomLevel = MTSMapZoomLevelFromScale(scale);
    
	NSUInteger x = floor(crect.origin.x / crect.size.width);
	NSUInteger y = floor(crect.origin.y / crect.size.width);
	
	NSData* tileData = [cache tileWithPrefix:tileProvider.prefix atX:x y:y zoomLevel:zoomLevel];
	
	if (!tileData)
    {
		NSURL* tileURL = [tileProvider tileURLForTile:x y:y zoomLevel:zoomLevel];
		tileData = [[NSData alloc] initWithContentsOfURL:tileURL];
		
		if (!tileData)
			return;
		
		[cache setTile:tileData prefix:tileProvider.prefix x:x y:y zoomLevel:zoomLevel];
	}
	
	UIImage* tileImage = [[UIImage alloc] initWithData:tileData];
	
	[tileImage drawInRect:crect];
}

@end

#endif