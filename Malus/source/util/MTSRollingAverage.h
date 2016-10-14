//
//  MTSRollingAverage.h
//  MTS
//
//  Created by Roland Rabien on 2013-09-12.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTSRollingAverage : NSObject {
    int numVals;
    double current;
}

- (id)initWithNumberOfPoints:(int)numDatumPoints;
- (double)average:(double)value;
- (double)current;

@end
