//
//  MTSSimpleTableViewItemCheck.h
//  MTS
//
//  Created by Roland Rabien on 2013-09-13.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "MTSSimpleTableViewItem.h"

@interface MTSSimpleTableViewItemCheck : MTSSimpleTableViewItem

@property (nonatomic) NSString* setting;
@property (nonatomic) NSString* value;
@property (nonatomic) NSString* notification;

@end
#endif