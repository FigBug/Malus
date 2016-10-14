//
//  MTSMapView.h
//  MapKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "MTSMapTypes.h"
#import "MTSMapPath.h"
#import "MTSMapBaseView.h"

@class MTSMapBaseView;
@protocol MTSTileProvider, MTSProjection;

/*
  NOTE: MTSMapView sets itself as the delegate of its UIScrollView superclass
  Don't change it!
  
  The QuartzCore framework must also be linked against in order to use MTSMapView
*/

@interface MTSMapView : UIScrollView <UIScrollViewDelegate>
{
@private
	MTSMapBaseView* baseView;
	
	id <MTSTileProvider> tileProvider;
	id <MTSProjection> mapProjection;
}

/*
  If you don't use the - initWithFrame:tileProvider: initializer, the
  tile provider will be nil. It MUST be set in order to display any tiles
*/
@property (nonatomic, retain) id <MTSTileProvider> tileProvider;

// The default projection is MTSMercatorProjection
@property (nonatomic, retain) id <MTSProjection> mapProjection;

@property (nonatomic, assign) MTSMapCoordinate centerCoordinate; // animated
@property (nonatomic, assign) NSUInteger zoomLevel;   // animated


// tileProvider must not be nil
- (id)initWithFrame:(CGRect)frame tileProvider:(id <MTSTileProvider>)tileProvider;

- (void)setCenterCoordinate:(MTSMapCoordinate)coord animated:(BOOL)anim;
- (void)setZoomLevel:(NSUInteger)zoom animated:(BOOL)anim;

- (void)addPath:(MTSMapPath*)path;
- (void)removePath:(MTSMapPath*)path;

@end
#endif