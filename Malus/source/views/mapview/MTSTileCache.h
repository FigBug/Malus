//
//  MTSTileCache.h
//  MapKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface MTSTileCache : NSObject {
  @private
	NSUInteger _maxCacheSize;
	NSString *_cacheDirectory;
	BOOL _flushing;
}

@property (assign) NSUInteger maxCacheSize; /* in tiles, default=1,000 */
@property (readonly) NSString *cacheDirectory;

- (id)initWithCacheDirectory:(NSString *)aPath;

// thread safe...
- (NSData*)tileWithPrefix:(NSString*)prefix atX:(NSUInteger)x y:(NSUInteger)y zoomLevel:(NSUInteger)zoom;
- (void)setTile:(NSData*)data prefix:(NSString*)prefix x:(NSUInteger)x y:(NSUInteger)y zoomLevel:(NSUInteger)zoom;

// Dispatches a new thread and flushes old caches from the disk
- (void)flushOldCaches;

@end
