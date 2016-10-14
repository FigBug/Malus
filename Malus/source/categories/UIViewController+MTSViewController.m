//
//  UIViewController+MTSViewController.m
//  MTS
//
//  Created by Roland Rabien on 11/15/2013.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "UIViewController+MTSViewController.h"

@implementation UIViewController (MTSViewController)

- (void)setOpaqueNavBar
{
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 7.0)
        self.navigationController.navigationBar.translucent = NO;
}

@end
#endif