//
//  MTSLocationWatcher.h
//
//  Created by Roland Rabien on 2013-08-02.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

@protocol MTSLocationWatcher <NSObject>

@required
- (void)locationUpdated:(CLLocation*)location;

@optional
- (CLLocationAccuracy)accuracyRequired;

@end
