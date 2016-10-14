//
// MTSSimpleTableViewItem.h
//  Util
//
//  Created by Roland Rabien on 2013-08-02.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

#import "MTSSimpleTableViewItemProtocol.h"
#import "MTSSimpleTableViewOwner.h"

@class MTSSimpleTableViewController;
@class MTSSimpleTableViewGroup;

@interface MTSSimpleTableViewItem : NSObject<MTSSimpleTableViewItemProtocol> {
    MTSSimpleTableViewGroup* __weak group;
    id<MTSSimpleTableViewOwner> __weak owner;
    BOOL enabled;
}

@property (nonatomic) NSString* text;
@property (nonatomic) NSTextAlignment textAlignment;
@property (nonatomic) NSString* detailText;
@property (nonatomic) UITableViewCellStyle style;
@property (nonatomic) UITableViewCellAccessoryType accessory;
@property (nonatomic) UIView* accessoryView;
@property (nonatomic,copy) id userData;
@property (nonatomic,copy) BOOL(^selectBlock)(MTSSimpleTableViewItem* item);
@property (nonatomic,copy) BOOL(^deleteBlock)(MTSSimpleTableViewItem* item);
@property (nonatomic,copy) BOOL(^enabledBlock)(MTSSimpleTableViewItem* item);

- (id)initWithOwner:(id<MTSSimpleTableViewOwner>)owner group:(MTSSimpleTableViewGroup*)group;
- (void)configureCell:(UITableViewCell*)cell;
- (NSIndexPath*)indexPath;
- (UITableViewCell*)cell;
- (BOOL)enabled;
- (void)setEnabled:(BOOL)enabled;
- (void)updateEnabledState;

@end
#endif