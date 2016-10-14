//
//  UIView+MTSView.h
//  MTS
//
//  Created by Roland Rabien on 2013-10-09.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

@interface UIView (MTSView)

- (UIView*)findFirstResponder;

@end
#endif