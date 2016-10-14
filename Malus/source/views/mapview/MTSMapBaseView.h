//
//  MTSMapBaseView.h
//  Util
//
//  Created by Roland Rabien on 2013-08-05.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

#import <Malus/MTSTileProvider.h>
#import <Malus/MTSTileCache.h>

@interface MTSMapBaseView : UIView
{
@private
	MTSTileCache* cache;
	id<MTSTileProvider> tileProvider;
}

@property (nonatomic, assign) id <MTSTileProvider> tileProvider;
@property (nonatomic) NSMutableArray* mapPaths;

- (void)configureLayer;
- (NSString *)cacheDirectory;

@end

#endif