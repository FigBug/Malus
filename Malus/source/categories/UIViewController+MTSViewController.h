//
//  UIViewController+MTSViewController.h
//  MTS
//
//  Created by Roland Rabien on 11/15/2013.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

@interface UIViewController (MTSViewController)

- (void)setOpaqueNavBar;

@end
#endif