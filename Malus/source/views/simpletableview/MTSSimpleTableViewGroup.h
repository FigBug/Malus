//
// MTSSimpleTableViewGroup.h
//  Util
//
//  Created by Roland Rabien on 2013-08-02.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#import "MTSSimpleTableViewOwner.h"

@class MTSSimpleTableViewItem;
@class MTSSimpleTableViewItemCheck;
@class MTSSimpleTableViewItemSlider;
@class MTSSimpleTableViewItemDualSlider;
@class MTSSimpleTableViewItemSwitch;
@class MTSSimpleTableViewController;

@interface MTSSimpleTableViewGroup : NSObject {
    id<MTSSimpleTableViewOwner> __weak owner;
    
    NSMutableArray* items;
}

@property (nonatomic) NSString* name;
@property (nonatomic) NSString* footer;
@property (nonatomic,readonly) NSArray* items;

- (id)initWithOwner:(id<MTSSimpleTableViewOwner>)owner name:(NSString*)name;

- (MTSSimpleTableViewItem*)addItem;
- (MTSSimpleTableViewItem*)addItemText:(NSString*)name;
- (MTSSimpleTableViewItem*)addItemText:(NSString*)name detailText:(NSString*)detailText;
- (MTSSimpleTableViewItem*)addItemText:(NSString*)name detailText:(NSString*)detailText style:(UITableViewCellStyle)style;

- (MTSSimpleTableViewItem*)addItemButtonText:(NSString*)name select:(BOOL(^)(MTSSimpleTableViewItem* item))select;

- (MTSSimpleTableViewItemCheck*)addItemCheckText:(NSString*)name setting:(NSString*)setting value:(id)value;
- (MTSSimpleTableViewItemCheck*)addItemCheckText:(NSString*)name setting:(NSString*)setting value:(id)value notification:(NSString*)notification;

- (MTSSimpleTableViewItemSlider*)addItemSliderText:(NSString*)name settings:(NSString*)setting min:(double)min max:(double)max step:(double)step;
- (MTSSimpleTableViewItemSlider*)addItemSliderText:(NSString*)name settings:(NSString*)setting min:(double)min max:(double)max step:(double)step notification:(NSString*)notification;

- (MTSSimpleTableViewItemDualSlider*)addItemDualSliderText:(NSString*)name minSetting:(NSString*)minSetting maxSetting:(NSString*)maxSetting min:(double)min max:(double)max step:(double)step;
- (MTSSimpleTableViewItemDualSlider*)addItemDualSliderText:(NSString*)name minSetting:(NSString*)minSetting maxSetting:(NSString*)maxSetting min:(double)min max:(double)max step:(double)step notification:(NSString*)notification;

- (MTSSimpleTableViewItemSwitch*)addItemSwitchText:(NSString*)name detailText:(NSString*)detailText;
- (MTSSimpleTableViewItemSwitch*)addItemSwitchText:(NSString*)name setting:(NSString*)setting;
- (MTSSimpleTableViewItemSwitch*)addItemSwitchText:(NSString*)name setting:(NSString*)setting notification:(NSString*)notification;

- (BOOL)removeItem:(MTSSimpleTableViewItem*)item;

@end
#endif