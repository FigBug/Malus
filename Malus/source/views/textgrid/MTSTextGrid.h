//
//  MTSTextGrid.h
//
//  Created by Roland Rabien on 2013-08-27.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

@class MTS2DArray;

@interface MTSTextGrid : UIView {
    MTS2DArray* text;
    NSMutableArray* columnWidths;
}

@property (nonatomic) UIFont* font;
@property (nonatomic) double rowHeight;
@property (nonatomic) double defaultColumnWidth;

- (void)setText:(NSString*)text atRow:(int)row column:(int)col color:(UIColor*)color strokeColor:(UIColor*)stroke;
- (void)setColumn:(int)col width:(double)width;
- (void)clear;

@end
#endif