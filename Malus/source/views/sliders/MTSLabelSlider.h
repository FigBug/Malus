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

@protocol MTSLabelSliderDelegate;

@interface MTSLabelSlider : UIView {
    UISlider* slider;
    UILabel* label;
    double stepValue;
    id<MTSLabelSliderDelegate> delegate;
}

@property (nonatomic) id<MTSLabelSliderDelegate> delegate;
@property (nonatomic) float value;
@property (nonatomic) float maximumValue;
@property (nonatomic) float minimumValue;
@property (nonatomic, getter=isContinuous) BOOL continuous;
@property (nonatomic,readonly) UISlider* slider;
@property (nonatomic,readonly) UILabel* label;
@property (nonatomic) double stepSize;
@property (nonatomic) BOOL enabled;

@end

@protocol MTSLabelSliderDelegate
- (NSString*)textForValue:(MTSLabelSlider*)slider value:(float)value;
@end
#endif