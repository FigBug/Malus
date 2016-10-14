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
#import "MTSLabelRangeSlider.h"

@interface MTSSimpleTableViewItemDualSlider : MTSSimpleTableViewItem<MTSLabelRangeSliderDelegate>

@property (nonatomic) MTSLabelRangeSlider* slider;
@property (nonatomic) NSString* minSetting;
@property (nonatomic) NSString* maxSetting;
@property (nonatomic) double min;
@property (nonatomic) double max;
@property (nonatomic) double step;
@property (nonatomic) NSString* notification;
@property (nonatomic,copy) BOOL(^slidBlock)(MTSSimpleTableViewItem* item);
@property (nonatomic,copy) NSString*(^labelTextBlock)(MTSSimpleTableViewItemDualSlider* item, double lowerValue, double upperValue);

- (id)initWithOwner:(id<MTSSimpleTableViewOwner>)owner group:(MTSSimpleTableViewGroup*)group;

@end
#endif