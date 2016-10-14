//
//  MTSSimpleTableViewItemCheck.h
//  MTS
//
//  Created by Roland Rabien on 2013-09-13.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

#import "MTSSimpleTableViewItem.h"
#import "MTSLabelSlider.h"

@interface MTSSimpleTableViewItemSlider : MTSSimpleTableViewItem<MTSLabelSliderDelegate>

@property (nonatomic) MTSLabelSlider* slider;
@property (nonatomic) NSString* setting;
@property (nonatomic) double min;
@property (nonatomic) double max;
@property (nonatomic) double step;
@property (nonatomic) NSString* notification;
@property (nonatomic,copy) BOOL(^slidBlock)(MTSSimpleTableViewItem* item);
@property (nonatomic,copy) NSString*(^labelTextBlock)(MTSSimpleTableViewItemSlider* item, double value);

- (id)initWithOwner:(id<MTSSimpleTableViewOwner>)owner group:(MTSSimpleTableViewGroup*)group;

@end
#endif