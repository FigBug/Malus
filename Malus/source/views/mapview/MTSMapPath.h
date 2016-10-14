//
//  MTSMapPath.h
//  Util
//
//  Created by Roland Rabien on 2013-08-05.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

@interface MTSMapPath : NSObject {
    NSMutableArray* points;
}

@property (nonatomic) UIColor* color;
@property (nonatomic,readonly) NSArray* points;

@end
#endif