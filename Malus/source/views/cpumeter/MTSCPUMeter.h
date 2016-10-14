//
//  MTSCPUMeter.h
//  MTS
//
//  Created by Roland Rabien on 2013-09-11.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>
@class MTSTimer;

// CPU Usage from:
// http://stackoverflow.com/questions/8223348/ios-get-cpu-usage-from-application

@interface MTSCPUMeter : UILabel {
    MTSTimer* timer;
}

@end
#endif