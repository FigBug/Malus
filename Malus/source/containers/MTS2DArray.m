
//
//  MTS2DArray.m
//
//  Created by Roland Rabien on 2013-08-27.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#import "MTS2DArray.h"

@implementation MTS2DArray

- (id)init
{
    self = [super init];
    if (self)
    {
        rows = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)ensureExistsRow:(int)r column:(int)c
{
    while (rows.count <= r)
        [rows addObject:[[NSMutableArray alloc] init]];
    
    NSMutableArray* row = [rows objectAtIndex:r];
    
    while (row.count <= c)
        [row addObject:[NSNull null]];
}

- (void)shrink
{
    for (NSMutableArray* row in rows)
    {
        while (row.count > 0 && ([row lastObject] == [NSNull null]))
            [row removeLastObject];
    }
    
   while (rows.count > 0 && [[rows lastObject] count] == 0)
       [rows removeLastObject];
}

- (id)objectAtRow:(int)r column:(int)c
{
    NSMutableArray* row = (r < rows.count) ? [rows objectAtIndex:r] : nil;
    
    if (row && c < row.count)
        return [row objectAtIndex:c];

    return [NSNull null];
}

- (void)setObject:(id)obj atRow:(int)r column:(int)c
{
    [self ensureExistsRow:r column:c];
    
    NSMutableArray* row = [rows objectAtIndex:r];
    [row replaceObjectAtIndex:c withObject:obj];
}

- (void)removeObjectAtRow:(int)r column:(int)c
{
    NSMutableArray* row = (r < rows.count) ? [rows objectAtIndex:r] : nil;
    
    if (row && c < row.count)
    {
        [row replaceObjectAtIndex:c withObject:[NSNull null]];
        [self shrink];
    }
}

- (void)removeObject:(id)obj
{
    for (NSMutableArray* row in rows)
    {
        if ([row containsObject:obj])
        {
            [row removeObject:obj];
            break;
        }
    }
    [self shrink];
}

- (int)rows
{
    return (int)rows.count;
}

- (int)columns
{
    int cols = 0;
    
    for (NSMutableArray* row in rows)
        cols = (int)MAX(cols, row.count);
    
    return cols;
}

- (void)removeAllObjects
{
    rows = [[NSMutableArray alloc] init];
}

@end
