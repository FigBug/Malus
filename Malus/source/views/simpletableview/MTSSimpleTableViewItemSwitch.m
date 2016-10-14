//
//  MTSSimpleTableViewItemCheck.m
//  MTS
//
//  Created by Roland Rabien on 2013-09-13.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "MTSSimpleTableViewItemSwitch.h"
#import "MTSSimpleTableViewController.h"
#import "MTSSimpleTableViewGroup.h"
#import "MTSDefaults.h"

@implementation MTSSimpleTableViewItemSwitch

@synthesize setting;
@synthesize notification;
@synthesize uiSwitch;
@synthesize switchedBlock;

- (id)initWithOwner:(id<MTSSimpleTableViewOwner>)owner_ group:(MTSSimpleTableViewGroup*)group_
{
    self = [super initWithOwner:owner_ group:group_];
    if (self)
    {
        uiSwitch = [[UISwitch alloc] init];
        [uiSwitch addTarget:self action:@selector(switched:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)configureCell:(UITableViewCell*)cell
{
    self.accessoryView = uiSwitch;
    
    [super configureCell:cell];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (setting)
    {
        NSNumber* value = [MTSDefaults objectForKey:setting defaultValue:nil];
        if (value && value.boolValue)
            uiSwitch.on = YES;
        else
            uiSwitch.on = NO;
    }
}

-(void)switched:(id)sender
{
    if (setting)
        MTSDefaultsSetBoolForKey(setting, uiSwitch.on);
    
    if (switchedBlock)
        switchedBlock(self, uiSwitch.on);
    
    if (notification)
        [[NSNotificationCenter defaultCenter] postNotificationName:notification object:nil];
    
    [owner updateEnabledStates];
}

@end
#endif