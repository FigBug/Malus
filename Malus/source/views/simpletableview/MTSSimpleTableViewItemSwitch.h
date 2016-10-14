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

@interface MTSSimpleTableViewItemSwitch : MTSSimpleTableViewItem

@property (nonatomic) NSString* setting;
@property (nonatomic) NSString* notification;
@property (nonatomic) UISwitch* uiSwitch;
@property (nonatomic,copy) void(^switchedBlock)(MTSSimpleTableViewItemSwitch* item, BOOL on);

- (id)initWithOwner:(id<MTSSimpleTableViewOwner>)owner group:(MTSSimpleTableViewGroup*)group;

@end
#endif