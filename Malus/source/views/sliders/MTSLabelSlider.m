//
//  MTSLabelSlider.m
//  MTS
//
//  Created by Roland Rabien on 2012-10-19.
//  Copyright (c) 2012 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "MTSLabelSlider.h"

@implementation MTSLabelSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        slider = [[UISlider alloc] init];
        label  = [[UILabel alloc] init];
        
        [self addSubview:slider];
        [self addSubview:label];
        
        [self layoutSubviews];
        
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment   = NSTextAlignmentRight;
        label.text = @"0";
        
        [self updateLabel];
        
        [slider addTarget:self action:@selector(updateLabel) forControlEvents:UIControlEventValueChanged];
        
        stepValue = 0;
        
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

- (float)value
{
    return slider.value;
}

- (void)setValue:(float)value
{
    slider.value = value;
    
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
    return slider.isContinuous;
}

- (void)setContinuous:(BOOL)continuous
{
    slider.continuous = continuous;
}

- (void)updateLabel
{
    if (stepValue > 0)
    {
        float newStep = roundf((slider.value) / stepValue);
        
        double newVal = newStep * stepValue;
        if (newVal != slider.value)
            slider.value = newVal;
    }
    
    if (delegate)
        label.text = [delegate textForValue:self value:slider.value];
    else
        label.text = [NSString stringWithFormat:@"%.1f", slider.value];
}

- (UISlider*)slider
{
    return slider;
}

- (UILabel*)label
{
    return label;
}

- (id<MTSLabelSliderDelegate>)delegate
{
    return delegate;
}

- (void)setDelegate:(id<MTSLabelSliderDelegate>)delegate_
{
    delegate = delegate_;
    
    [self updateLabel];
}

- (double)stepSize
{
    return stepValue;
}

- (void)setStepSize:(double)stepSize
{
    stepValue = stepSize;
    
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