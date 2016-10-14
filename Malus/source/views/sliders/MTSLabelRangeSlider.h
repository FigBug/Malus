//
//  MTSLabelSlider.h
//  MTS
//
//  Created by Roland Rabien on 2012-10-19.
//  Copyright (c) 2012 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

@class NMRangeSlider;
@protocol MTSLabelRangeSliderDelegate;

@interface MTSLabelRangeSlider : UIView {
    NMRangeSlider* slider;
    UILabel* label;
    id<MTSLabelRangeSliderDelegate> delegate;
}

@property (nonatomic) id<MTSLabelRangeSliderDelegate> delegate;
@property (nonatomic) float lowerValue;
@property (nonatomic) float upperValue;
@property (nonatomic) float maximumValue;
@property (nonatomic) float minimumValue;
@property (nonatomic, getter=isContinuous) BOOL continuous;
@property (nonatomic,readonly) NMRangeSlider* slider;
@property (nonatomic,readonly) UILabel* label;
@property (nonatomic) double stepSize;
@property (nonatomic) BOOL enabled;

@end

@protocol MTSLabelRangeSliderDelegate
- (NSString*)textForValue:(MTSLabelRangeSlider*)slider lower:(float)v1 upper:(float)v2;
@end
#endif