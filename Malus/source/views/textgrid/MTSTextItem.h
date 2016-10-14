//
//  MTSTextItem.h
//
//  Created by Roland Rabien on 2013-08-27.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

@interface MTSTextItem : NSObject

@property (nonatomic) NSString* text;
@property (nonatomic) UIColor* color;
@property (nonatomic) UIColor* strokeColor;

@end
#endif