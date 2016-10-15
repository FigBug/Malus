//
//  MTSSimpleTableView.h
//  Malus
//
//  Created by Roland Rabien on 2016-07-22.
//  Copyright © 2016 Roland Rabien Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

#import "MTSSimpleTableViewGroup.h"
#import "MTSSimpleTableViewOwner.h"

@interface MTSSimpleTableView : UITableView<UITableViewDelegate, UITableViewDataSource, MTSSimpleTableViewOwner> {
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
