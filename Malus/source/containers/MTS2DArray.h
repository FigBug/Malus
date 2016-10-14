//
//  MTS2DArray.h
//
//  Created by Roland Rabien on 2013-08-27.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface MTS2DArray : NSObject {
    NSMutableArray* rows;
}

- (id)objectAtRow:(int)row column:(int)col;
- (void)setObject:(id)obj atRow:(int)row column:(int)col;
- (void)removeObjectAtRow:(int)row column:(int)col;
- (void)removeObject:(id)obj;
- (int)rows;
- (int)columns;
- (void)removeAllObjects;

@end
