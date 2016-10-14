//
//  MTSButterworthFilter.h
//  LibMTS
//
//  Created by Roland Rabien on 2013-09-04.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

@interface MTSButterworthFilter : NSObject {
    double xv[3];
    double yv[3];
    
    double ax[3];
    double by[3];
}

- (id)initWithSampleRate:(int)rate cuttoffFrequnecy:(double)freq;
- (double)filter:(double)val;

@end
