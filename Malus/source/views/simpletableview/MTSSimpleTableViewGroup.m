//
// MTSSimpleTableViewGroup.m
//  Util
//
//  Created by Roland Rabien on 2013-08-02.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "MTSSimpleTableViewGroup.h"
#import "MTSSimpleTableViewItem.h"
#import "MTSSimpleTableViewItemCheck.h"
#import "MTSSimpleTableViewItemSlider.h"
#import "MTSSimpleTableViewItemDualSlider.h"
#import "MTSSimpleTableViewItemSwitch.h"
#import "MTSSimpleTableViewController.h"

@implementation MTSSimpleTableViewGroup

@synthesize name;
@synthesize footer;

- (id)initWithOwner:(id<MTSSimpleTableViewOwner>)owner_ name:(NSString*)name_
{
    self = [super init];
    if (self)
    {
        owner   = owner_;
        items   = [[NSMutableArray alloc] init];
        name    = name_;
    }
    return self;
}

- (NSArray*)items
{
    return [items copy];
}

- (MTSSimpleTableViewItem*)addItem
{
    return [self addItemText:nil detailText:nil style:UITableViewCellStyleSubtitle];
}

- (MTSSimpleTableViewItem*)addItemText:(NSString*)text
{
    return [self addItemText:text detailText:nil style:UITableViewCellStyleSubtitle];
}

- (MTSSimpleTableViewItem*)addItemText:(NSString*)text detailText:(NSString*)detailText
{
    return [self addItemText:text detailText:detailText style:UITableViewCellStyleSubtitle];
}

- (MTSSimpleTableViewItem*)addItemText:(NSString*)text detailText:(NSString*)detailText style:(UITableViewCellStyle)style
{
    MTSSimpleTableViewItem* item = [[MTSSimpleTableViewItem alloc] initWithOwner:owner group:self];
    item.text       = text;
    item.detailText = detailText;
    item.style      = style;
    
    [items addObject:item];
    
    [owner reload];
    
    return item;
}

- (MTSSimpleTableViewItem*)addItemButtonText:(NSString*)text select:(BOOL(^)(MTSSimpleTableViewItem* item))select
{
    MTSSimpleTableViewItem* item = [self addItemText:text];
    
    item.selectBlock    = select;
    item.style          = UITableViewCellStyleDefault;
    item.textAlignment  = NSTextAlignmentCenter;
    
    return item;
}

- (MTSSimpleTableViewItemCheck*)addItemCheckText:(NSString*)text setting:(NSString*)setting value:(id)value
{
    return [self addItemCheckText:text setting:setting value:value notification:nil];
}

- (MTSSimpleTableViewItemCheck*)addItemCheckText:(NSString*)text setting:(NSString*)setting value:(id)value notification:(NSString*)notification
{
    MTSSimpleTableViewItemCheck* item = [[MTSSimpleTableViewItemCheck alloc] initWithOwner:owner group:self];
    item.text           = text;
    item.detailText     = nil;
    item.setting        = setting;
    item.value          = value;
    item.notification   = notification;
    
    [items addObject:item];
    
    [owner reload];
    
    return item;
}

- (MTSSimpleTableViewItemSlider*)addItemSliderText:(NSString*)text settings:(NSString*)setting min:(double)min max:(double)max step:(double)step
{
    return [self addItemSliderText:text settings:setting min:min max:max step:step notification:nil];
}

- (MTSSimpleTableViewItemSlider*)addItemSliderText:(NSString*)text settings:(NSString*)setting min:(double)min max:(double)max step:(double)step notification:(NSString*)notification
{
    MTSSimpleTableViewItemSlider* item = [[MTSSimpleTableViewItemSlider alloc] initWithOwner:owner group:self];
    item.text           = text;
    item.detailText     = nil;
    item.setting        = setting;
    item.min            = min;
    item.max            = max;
    item.step           = step;
    item.notification   = notification;
    
    [items addObject:item];
    
    [owner reload];
    
    return item;
}

- (MTSSimpleTableViewItemDualSlider*)addItemDualSliderText:(NSString*)text minSetting:(NSString*)minSetting maxSetting:(NSString*)maxSetting min:(double)min max:(double)max step:(double)step
{
    return [self addItemDualSliderText:text minSetting:minSetting maxSetting:maxSetting min:min max:max step:step notification:nil];
}

- (MTSSimpleTableViewItemDualSlider*)addItemDualSliderText:(NSString*)text minSetting:(NSString*)minSetting maxSetting:(NSString*)maxSetting min:(double)min max:(double)max step:(double)step notification:(NSString*)notification
{
    MTSSimpleTableViewItemDualSlider* item = [[MTSSimpleTableViewItemDualSlider alloc] initWithOwner:owner group:self];
    item.text           = text;
    item.detailText     = nil;
    item.minSetting     = minSetting;
    item.maxSetting     = maxSetting;
    item.min            = min;
    item.max            = max;
    item.step           = step;
    item.notification   = notification;
    
    [items addObject:item];
    
    [owner reload];
    
    return item;
}

- (MTSSimpleTableViewItemSwitch*)addItemSwitchText:(NSString*)text detailText:(NSString*)detailText
{
    MTSSimpleTableViewItemSwitch* sw = [self addItemSwitchText:text setting:nil notification:nil];
    sw.detailText = detailText;
    return sw;
}

- (MTSSimpleTableViewItemSwitch*)addItemSwitchText:(NSString*)text setting:(NSString*)setting
{
    return [self addItemSwitchText:text setting:setting notification:nil];
}

- (MTSSimpleTableViewItemSwitch*)addItemSwitchText:(NSString*)text setting:(NSString*)setting notification:(NSString*)notification
{
    MTSSimpleTableViewItemSwitch* item = [[MTSSimpleTableViewItemSwitch alloc] initWithOwner:owner group:self];
    item.text           = text;
    item.detailText     = nil;
    item.setting        = setting;
    item.notification   = notification;
    
    [items addObject:item];
    
    [owner reload];
    
    return item;

}

- (BOOL)removeItem:(MTSSimpleTableViewItem*)item
{
    if ([items containsObject:item])
    {
        [items removeObject:item];
        return YES;
    }
    return NO;
}

@end
#endif