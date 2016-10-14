//
//  MTSMapView.m
//  MapKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "MTSMapView.h"

#import "MTSMercatorProjection.h"
#import "MTSProjection.h"
#import "MTSTileCache.h"
#import "MTSTileProvider.h"
#import "MTSMapQuestOSMTileProvider.h"

@implementation MTSMapView

@synthesize tileProvider = tileProvider;
@synthesize mapProjection = mapProjection;
@dynamic centerCoordinate, zoomLevel;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
    {
		[self setup];
	}
	return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self)
    {
		[self setup];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame tileProvider:(id <MTSTileProvider>)tileProvider_
{
	NSParameterAssert (tileProvider != nil);
	
	self = [self initWithFrame:frame];
	if (self)
    {
		self.tileProvider = tileProvider_;
	}
	return self;
}

- (void)setup
{
	self.backgroundColor                = [UIColor grayColor];
	self.showsHorizontalScrollIndicator = NO;
	self.showsVerticalScrollIndicator   = NO;
	self.scrollsToTop                   = NO;
	self.bounces                        = NO;
    self.pagingEnabled                  = NO;
	
	self.mapProjection = [[MTSMercatorProjection alloc] init];
    self.tileProvider  = [[MTSMapQuestOSMTileProvider alloc] init];
}

- (void)configureScrollView
{
	self.contentSize        = [tileProvider tileSize];
	self.minimumZoomScale   = 1.0f;
	self.maximumZoomScale   = MTSMapScaleFromZoomLevel([tileProvider maxZoomLevel]);
	self.delegate           = tileProvider ? self : nil;
}

- (void)addPath:(MTSMapPath*)path
{
    [baseView.mapPaths addObject:path];
    [baseView setNeedsDisplay];
}

- (void)removePath:(MTSMapPath*)path
{
    [baseView.mapPaths removeObject:path];
    [baseView setNeedsDisplay];
}

- (void)configureLayers
{
	if (!baseView)
    {
		baseView = [[MTSMapBaseView alloc] initWithFrame:[self bounds]];
		baseView.multipleTouchEnabled = YES;
		
		[self insertSubview:baseView atIndex:0];
    }
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	// center map if necessary
	CGSize boundsSize = self.bounds.size;
	CGRect frameToCenter = baseView.frame;
	
	if (frameToCenter.size.width < boundsSize.width)
		frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
	else
		frameToCenter.origin.x = 0;
	
	if (frameToCenter.size.height < boundsSize.height)
		frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
	else
		frameToCenter.origin.y = 0;
	
	baseView.frame = frameToCenter;

	// Support higher resolution displays
	baseView.contentScaleFactor = 1.0f / [UIScreen mainScreen].scale;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return baseView;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesEnded:touches withEvent:event];
	
	UITouch *touch = [touches anyObject];
	NSUInteger zoom = MTSMapZoomLevelFromScale(self.zoomScale);
	
	if ([touches count] == 1 && touch.tapCount == 2)
    {
		// zoom in
		if (zoom < [tileProvider maxZoomLevel])
        {
			CGPoint pt = [touch locationInView:self];
			
			MTSMapCoordinate coord = [mapProjection coordinateForPoint:pt zoomLevel:zoom tileSize:[tileProvider tileSize]];
			zoom++;
			
			[self setCenterCoordinate:coord animated:NO];
			self.zoomLevel = zoom;
		}
	}
	else if ([touches count] == 2 && touch.tapCount == 1)
    {
		// zoom out
		if (zoom > [tileProvider minZoomLevel])
        {
			self.zoomLevel = zoom--;
		}
	}
}

- (void)setTileProvider:(id < MTSTileProvider > )prov
{
	if (tileProvider != prov)
    {
        tileProvider = prov;
        
		[self configureScrollView];
		[self configureLayers];
		
		baseView.tileProvider = tileProvider;
		
		[self setCenterCoordinate:MTSMapCoordinateMake(0, 0) animated:NO];
        
        [self setNeedsDisplay];
	}
}

- (NSUInteger)zoomLevel
{
	return MTSMapZoomLevelFromScale(self.zoomScale);
}

- (void)setZoomLevel:(NSUInteger)zoom
{
	[self setZoomLevel:zoom animated:YES];
}

- (void)setZoomLevel:(NSUInteger)zoom animated:(BOOL)anim
{
	[self setZoomScale:MTSMapScaleFromZoomLevel(zoom) animated:anim];
}

- (MTSMapCoordinate)centerCoordinate
{
	CGPoint pt = self.contentOffset;
	pt.x += self.bounds.size.width  / 2;
	pt.y += self.bounds.size.height / 2;
	
	return [mapProjection coordinateForPoint:pt zoomLevel:self.zoomLevel tileSize:[tileProvider tileSize]];
}

- (void)setCenterCoordinate:(MTSMapCoordinate)coord
{
	[self setCenterCoordinate:coord animated:YES];
}

- (void)setCenterCoordinate:(MTSMapCoordinate)coord animated:(BOOL)anim
{
	CGPoint pt = [mapProjection pointForCoordinate:coord zoomLevel:self.zoomLevel tileSize:[tileProvider tileSize]];
	
	pt.x -= self.bounds.size.width  / 2;
	pt.y -= self.bounds.size.height / 2;
	
	[self setContentOffset:pt animated:anim];
}

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    [baseView setNeedsDisplay];
}

@end
#endif