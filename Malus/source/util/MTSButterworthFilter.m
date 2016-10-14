//
//  MTSButterworthFilter.m
//  LibMTS
//
//  Created by Roland Rabien on 2013-09-04.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "MTSButterworthFilter.h"

@implementation MTSButterworthFilter

- (id)initWithSampleRate:(int)sampleRate cuttoffFrequnecy:(double)cutoff
{
    self = [super init];
    if (self)
    {
        double PI      = 3.1415926535897932385;
        double sqrt2   = 1.4142135623730950488;
        
        double QcRaw  = (2 * PI * cutoff) / sampleRate; // Find cutoff frequency in [0..PI]
        double QcWarp = tan(QcRaw); // Warp cutoff frequency
        
        double gain   = 1 / (1 + sqrt2 / QcWarp + 2 / (QcWarp * QcWarp));
        
        by[2] = (1 - sqrt2 / QcWarp + 2 / (QcWarp * QcWarp)) * gain;
        by[1] = (2 - 2 * 2 / (QcWarp * QcWarp)) * gain;
        by[0] = 1;
        
        ax[0] = 1 * gain;
        ax[1] = 2 * gain;
        ax[2] = 1 * gain;
        
        memset(xv, 0, sizeof(xv));
        memset(yv, 0, sizeof(yv));
    }
    return self;
}

- (double)filter:(double)sample
{
    xv[2] = xv[1];
    xv[1] = xv[0];
    
    xv[0] = sample;
    
    yv[2] = yv[1];
    yv[1] = yv[0];
    
    yv[0] = (ax[0] * xv[0] + ax[1] * xv[1] + ax[2] * xv[2] - by[1] * yv[0] - by[2] * yv[1]);
    
    double v = yv[0];
    
    // sanity checking
    if (isinf(v) || isnan(v))
        return 0;
    
    if (v > 100000000 || v < -100000000)
        return 0;
    
    return v;
}

@end
