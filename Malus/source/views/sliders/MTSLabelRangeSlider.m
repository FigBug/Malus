//
//  MTSLabelSlider.m
//  MTS
//
//  Created by Roland Rabien on 2012-10-19.
//  Copyright (c) 2012 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "MTSLabelRangeSlider.h"
#import "NMRangeSlider.h"

@implementation MTSLabelRangeSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        slider = [[NMRangeSlider alloc] init];
        label  = [[UILabel alloc] init];
        
        slider.stepValueContinuously = NO;
        
        [self addSubview:slider];
        [self addSubview:label];
        
        [self layoutSubviews];
        
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment   = NSTextAlignmentRight;
        label.text = @"0";
        
        [self updateLabel];
        
        [slider addTarget:self action:@selector(updateLabel) forControlEvents:UIControlEventValueChanged];
        
        [self updateLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    CGRect rc = self.bounds;
    
    CGFloat w = rc.size.width;
    CGFloat h = rc.size.height;
    
    CGFloat dx = 130;
    
    CGRect rc1 = CGRectMake(dx, 0, w - dx - 10, h);
    CGRect rc2 = CGRectMake(0, 0, dx - 10, h);
    
    slider.frame  = rc1;
    label.frame   = rc2;
}

- (float)lowerValue
{
    return slider.lowerValue;
}

- (float)upperValue
{
    return slider.upperValue;
}

- (void)setLowerValue:(float)lowerValue
{
    slider.lowerValue = lowerValue;

    [self updateLabel];
}

- (void)setUpperValue:(float)upperValue
{
    slider.upperValue = upperValue;
    
    [self updateLabel];
}

- (float)maximumValue
{
    return slider.maximumValue;
}

- (void)setMaximumValue:(float)maximumValue
{
    slider.maximumValue = maximumValue;
}

- (float)minimumValue
{
    return slider.minimumValue;
}

- (void)setMinimumValue:(float)minimumValue
{
    slider.minimumValue = minimumValue;
}

- (BOOL)isContinuous
{
    return slider.continuous;
}

- (void)setContinuous:(BOOL)continuous
{
    slider.continuous = continuous;
}

- (void)updateLabel
{   
    if (delegate)
        label.text = [delegate textForValue:self lower:slider.lowerValue upper:slider.upperValue];
    else
        label.text = [NSString stringWithFormat:@"%.1f / %.1f", slider.lowerValue, slider.upperValue];
}

- (NMRangeSlider*)slider
{
    return slider;
}

- (UILabel*)label
{
    return label;
}

- (id<MTSLabelRangeSliderDelegate>)delegate
{
    return delegate;
}

- (void)setDelegate:(id<MTSLabelRangeSliderDelegate>)delegate_
{
    delegate = delegate_;
    
    [self updateLabel];
}

- (double)stepSize
{
    return slider.stepValue;
}

- (void)setStepSize:(double)stepSize
{
    slider.stepValue = stepSize;
    
    [self updateLabel];
}

- (void)setEnabled:(BOOL)enabled
{
    slider.enabled = enabled;
    label.enabled  = enabled;
}

- (BOOL)enabled
{
    return slider.enabled;
}

@end
#endif