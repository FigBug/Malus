//
//  UIView+MTSView.m
//  MTS
//
//  Created by Roland Rabien on 2013-10-09.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "UIView+MTSView.h"

@implementation UIView (MTSView)

- (UIView*)findFirstResponder
{
    if (self.isFirstResponder)
        return self;
    
    for (UIView* subView in self.subviews)
    {
        UIView* firstResponder = [subView findFirstResponder];
        
        if (firstResponder)
            return firstResponder;
    }
    
    return nil;
}

@end
#endif