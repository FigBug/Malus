//
//  MTSSimpleTableViewItemCheck.m
//  MTS
//
//  Created by Roland Rabien on 2013-09-13.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "MTSSimpleTableViewItemSlider.h"
#import "MTSSimpleTableViewController.h"
#import "MTSSimpleTableViewGroup.h"
#import "MTSDefaults.h"
#import "UIView+MTSRect.h"

@implementation MTSSimpleTableViewItemSlider

@synthesize slider;
@synthesize setting;
@synthesize min;
@synthesize max;
@synthesize step;
@synthesize notification;
@synthesize slidBlock;
@synthesize labelTextBlock;

- (id)initWithOwner:(id<MTSSimpleTableViewOwner>)owner_ group:(MTSSimpleTableViewGroup*)group_
{
    self = [super initWithOwner:owner_ group:group_];
    if (self)
    {
        slider = [[MTSLabelSlider alloc] init];
        
        [slider.slider addTarget:self action:@selector(slid:) forControlEvents:UIControlEventValueChanged];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:NULL];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configureCell:(UITableViewCell*)cell
{
    UITableView* table = owner.simpleTableView;
    
    CGFloat rowHeight = [table rectForRowAtIndexPath:[self indexPath]].size.height;
    
    slider.bounds = CGRectMake(0, 0, table.boundsRect.width * 2.0/3.0, rowHeight);
 
    slider.minimumValue = min;
    slider.maximumValue = max;
    slider.stepSize     = step;
    slider.delegate     = self;
    
    self.accessoryView = slider;
    
    [super configureCell:cell];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (setting)
    {
        NSNumber* value = [MTSDefaults objectForKey:setting defaultValue:nil];
        slider.value = value.doubleValue;
    }
}

-(void)slid:(id)sender
{
    if (setting)
        MTSDefaultsSetDoubleForKey(setting, slider.value);
    
    if (slidBlock)
        slidBlock(self);
    
    if (notification)
        [[NSNotificationCenter defaultCenter] postNotificationName:notification object:nil];
}

- (NSString*)textForValue:(MTSLabelSlider*)slider value:(float)value
{
    if (labelTextBlock)
        return labelTextBlock(self, value);
    return nil;
}

- (void)setEnabled:(BOOL)enabled_
{
    [super setEnabled:enabled_];
    
    slider.enabled = enabled_;
}

- (void)orientationDidChange:(NSNotification*)notification
{
    UITableView* table = owner.simpleTableView;
    
    CGFloat rowHeight = [table rectForRowAtIndexPath:[self indexPath]].size.height;
    
    slider.bounds = CGRectMake(0, 0, table.boundsRect.width * 2.0/3.0, rowHeight);
}

@end
#endif