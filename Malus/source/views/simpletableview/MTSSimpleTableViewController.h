//
// MTSSimpleTableViewController.h
//  Util
//
//  Created by Roland Rabien on 2013-08-02.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#import "MTSSimpleTableViewOwner.h"

@class MTSSimpleTableViewGroup;
@class MTSSimpleTableViewItem;

@interface MTSSimpleTableViewController : UITableViewController<MTSSimpleTableViewOwner> {
    NSMutableArray* groups;
}

- (void)clear;

- (NSArray*)groups;

- (MTSSimpleTableViewGroup*)addGroup;
- (MTSSimpleTableViewGroup*)addGroup:(NSString*)name;

- (void)reload;
- (void)updateEnabledStates;

- (UITableView*)simpleTableView;

@end
#endif