//
//  MTSSimpleTableViewItemCheck.m
//  MTS
//
//  Created by Roland Rabien on 2013-09-13.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "MTSSimpleTableViewItemCheck.h"
#import "MTSSimpleTableViewController.h"
#import "MTSSimpleTableViewGroup.h"
#import "MTSDefaults.h"

@implementation MTSSimpleTableViewItemCheck

@synthesize setting;
@synthesize value;
@synthesize notification;

- (void)configureCell:(UITableViewCell*)cell
{
    [super configureCell:cell];
    
    if (setting && [[MTSDefaults objectForKey:setting defaultValue:nil] isEqual:value])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
}

- (void)didSelectRow
{
    for (id item in group.items)
    {
        if ([item isKindOfClass:[MTSSimpleTableViewItemCheck class]])
        {
            MTSSimpleTableViewItemCheck* itemCheck = (MTSSimpleTableViewItemCheck*)item;
            if (setting && [itemCheck.setting isEqual:setting] && itemCheck != self)
            {
                UITableViewCell* cell = [itemCheck cell];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    }
    
    if (setting)
        [MTSDefaults setObject:value forKey:setting];
    
    UITableViewCell* cell = [self cell];
    if (cell)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

    if (notification)
        [[NSNotificationCenter defaultCenter] postNotificationName:notification object:nil];
    
    [owner.simpleTableView deselectRowAtIndexPath:[self indexPath] animated:YES];
    
    [owner updateEnabledStates];
}

@end

#endif