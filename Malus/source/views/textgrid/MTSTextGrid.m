//
//  MTSTextGrid.m
//
//  Created by Roland Rabien on 2013-08-27.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "MTSTextGrid.h"
#import "MTSTextItem.h"
#import "MTS2DArray.h"
#import "NSObject+MTSCast.h"

@implementation MTSTextGrid

@synthesize font;
@synthesize rowHeight;
@synthesize defaultColumnWidth;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    text                = [[MTS2DArray alloc] init];
    font                = [UIFont boldSystemFontOfSize:19];
    rowHeight           = 20;
    defaultColumnWidth  = 100;
    columnWidths        = [[NSMutableArray alloc] init];
    self.opaque         = NO;
}

- (void)drawString:(NSString*)string at:(CGPoint)pnt on:(CGContextRef)ctx color:(CGColorRef)color stoke:(CGColorRef)stroke
{
    CGContextSetLineDash(ctx, 0, NULL, 0);
    CGContextSetLineWidth(ctx, 1);
    
    CGContextSetFillColorWithColor(ctx, color);
    CGContextSetStrokeColorWithColor(ctx, color);
    
    CGContextSetTextDrawingMode(ctx, kCGTextFill);
    [string drawAtPoint:pnt withAttributes:@{ NSFontAttributeName : font}];
    
    CGContextSetFillColorWithColor(ctx, stroke);
    CGContextSetStrokeColorWithColor(ctx, stroke);
    
    if ([UIScreen mainScreen].scale >= 2.0)
    {
        CGContextSetTextDrawingMode(ctx, kCGTextStroke);
        [string drawAtPoint:pnt withAttributes:@{ NSFontAttributeName : font}];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClipToRect(ctx, rect);

    for (int y = 0; y < text.rows; y++)
    {
        for (int x = 0; x < text.columns; x++)
        {
            MTSTextItem* itm = [MTSTextItem cast:[text objectAtRow:y column:x]];
            if (itm)
            {
                CGPoint pt = CGPointMake([self columnPosition:x], y * rowHeight);
                [self drawString:itm.text at:pt on:ctx color:itm.color.CGColor stoke:itm.strokeColor.CGColor];
            }
        }
    }
}

- (void)setText:(NSString*)str atRow:(int)row column:(int)col color:(UIColor*)color strokeColor:(UIColor*)stroke
{
    MTSTextItem* itm = [[MTSTextItem alloc] init];
    itm.text        = str;
    itm.color       = color;
    itm.strokeColor = stroke;
    
    if (![itm isEqual:[text objectAtRow:row column:col]])
    {
        [text setObject:itm atRow:row column:col];
        
        [self setNeedsDisplayInRect:CGRectMake([self columnPosition: col], row * rowHeight, [self columnWidth:col], rowHeight + 3)];
    }
}

- (double)columnPosition:(int)col
{
    double pos = 0;
    
    for (int i = 0; i < col; i++)
        pos += [self columnWidth:i];

    return pos;
}

- (double)columnWidth:(int)col
{
    double width = defaultColumnWidth;
    if (col < columnWidths.count)
        width = [columnWidths[col] doubleValue];

    return width;
}

- (void)setColumn:(int)col width:(double)width
{
    while (columnWidths.count <= col)
        [columnWidths addObject:[NSNumber numberWithDouble:defaultColumnWidth]];
    
    [columnWidths replaceObjectAtIndex:col withObject:[NSNumber numberWithDouble:width]];
}

- (void)clear
{
    [text removeAllObjects];
    [self setNeedsDisplay];
}

@end

#endif