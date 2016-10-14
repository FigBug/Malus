//
//  MTSLocationManager.m
//
//  Created by Roland Rabien on 2013-08-02.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "MTSLocationManager.h"
#import "MTSLocationWatcher.h"

@implementation MTSLocationManager

+ (MTSLocationManager*)sharedLocationManager
{
    static MTSLocationManager* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MTSLocationManager alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        enabled  = NO;
        watchers = [[NSMutableArray alloc] init];

        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
    }
    return self;
}

- (CLLocationAccuracy)accuracyRequired
{
    CLLocationAccuracy req = kCLLocationAccuracyHundredMeters;
    
    for (id<MTSLocationWatcher> watcher in watchers)
    {
        if ([watcher respondsToSelector:@selector(accuracyRequired)])
        {
            CLLocationAccuracy r = [watcher accuracyRequired];
            if (r < req)
                req = r;
        }
    }
    return req;
}

- (void)addLocationWatcher:(id<MTSLocationWatcher>)watcher
{
    [watchers addObject:watcher];
    
    if (watchers.count == 1)
    {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];

        if (status == kCLAuthorizationStatusAuthorizedAlways      ||
            status == kCLAuthorizationStatusNotDetermined)
        {
            [locationManager startUpdatingLocation];
            locationManager.pausesLocationUpdatesAutomatically = NO;
            locationManager.distanceFilter  = kCLDistanceFilterNone;
            locationManager.desiredAccuracy = [self accuracyRequired];
            locationManager.activityType    = CLActivityTypeFitness;
            
            enabled = YES;
        }
    }
}

- (void)removeLocationWatcher:(id<MTSLocationWatcher>)watcher
{
    [watchers removeObject:watcher];
    
    if (enabled && watchers.count == 0)
    {
        [locationManager stopUpdatingLocation];
        enabled = NO;
    }
}

- (void)locationManager:(CLLocationManager*)manager didUpdateLocations:(NSArray*)locations
{
    for (id<MTSLocationWatcher> watcher in watchers)
    {
        for (CLLocation* location in locations)
            [watcher locationUpdated:location];
    }
}

- (void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError*)error
{
    for (id<MTSLocationWatcher> watcher in watchers)
    {
        [watcher locationUpdated:nil];
    }
}

- (void)locationManager:(CLLocationManager*)manager didFinishDeferredUpdatesWithError:(NSError*)error
{
}

@end
#endif