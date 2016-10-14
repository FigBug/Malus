//
//  MTSLocationManager.h
//
//  Created by Roland Rabien on 2013-08-02.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol MTSLocationWatcher;

@interface MTSLocationManager : NSObject<CLLocationManagerDelegate> {
    CLLocationManager* locationManager;
    NSMutableArray* watchers;
    BOOL enabled;
}

+ (MTSLocationManager*)sharedLocationManager;

- (void)addLocationWatcher:(id<MTSLocationWatcher>)watcher;
- (void)removeLocationWatcher:(id<MTSLocationWatcher>)watcher;

- (void)locationManager:(CLLocationManager*)manager didUpdateLocations:(NSArray*)locations;
- (void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError*)error;
- (void)locationManager:(CLLocationManager*)manager didFinishDeferredUpdatesWithError:(NSError*)error;

@end
