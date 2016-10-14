//
//  MTSVideoUtil.h
//
//  Created by Roland Rabien on 2012-12-03.
//  Copyright (c) 2012 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MTSVideoUtil : NSObject

+ (BOOL)trim:(NSString*)file start:(double)start length:(double)length done:(void(^)(BOOL ok))done;

#if TARGET_OS_IPHONE
+ (BOOL)generateThumbnail:(NSString*)videoPath done:(void(^)(UIImage*))done;
#endif

@end
