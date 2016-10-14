//
//  MTSRollingAverage.m
//  MTS
//
//  Created by Roland Rabien on 2013-09-12.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#import "MTSRollingAverage.h"

@implementation MTSRollingAverage

- (id)initWithNumberOfPoints:(int)numDatumPoints
{
    self = [super init];
    if (self)
    {
        numVals = numDatumPoints;
    }
    return self;
}

- (double)average:(double)next
{
    current = (next + numVals * current) / (double)(numVals + 1);
    return current;
}

- (double)current
{
    return current;
}

@end
