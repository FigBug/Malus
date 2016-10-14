//
//  MTSSimpleTableViewController.m
//  Util
//
//  Created by Roland Rabien on 2013-08-02.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "MTSSimpleTableViewController.h"
#import "MTSSimpleTableViewGroup.h"
#import "MTSSimpleTableViewItem.h"
#import "MTSUtil.h"

@implementation MTSSimpleTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        groups = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
        self.tableView.cellLayoutMarginsFollowReadableWidth = NO;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UITableView*)simpleTableView
{
    return self.tableView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return groups.count;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    MTSSimpleTableViewGroup* group = [groups objectAtIndex:section];
    return group.items.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    MTSSimpleTableViewGroup* group = [groups objectAtIndex:indexPath.section];
    MTSSimpleTableViewItem* item   = [group.items objectAtIndex:indexPath.item];

    static NSString* ident = nil;
    switch (item.style)
    {
        case UITableViewCellStyleDefault:   ident = @"cellDefault";     break;
        case UITableViewCellStyleValue1:    ident = @"cellValue1";      break;
        case UITableViewCellStyleValue2:    ident = @"cellValue2";      break;
        case UITableViewCellStyleSubtitle:  ident = @"cellSubtitle";    break;
    }
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ident];    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:item.style reuseIdentifier:ident];

    [item configureCell:cell];
        
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    MTSSimpleTableViewGroup* group = [groups objectAtIndex:section];
    return group.name;
}

- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    MTSSimpleTableViewGroup* group = [groups objectAtIndex:section];
    return group.footer;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        MTSSimpleTableViewGroup* group = [groups objectAtIndex:indexPath.section];
        MTSSimpleTableViewItem* item   = [group.items objectAtIndex:indexPath.item];
        
        if (item.deleteBlock(item))
        {
            [group removeItem:item];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    MTSSimpleTableViewGroup* group = [groups objectAtIndex:indexPath.section];
    MTSSimpleTableViewItem* item   = [group.items objectAtIndex:indexPath.item];

    if ([item respondsToSelector:@selector(didSelectRow)])
    {
        [item didSelectRow];
    }
    if (item.selectBlock)
    {
        if (!item.selectBlock(item))
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
{
    MTSSimpleTableViewGroup* group = [groups objectAtIndex:indexPath.section];
    MTSSimpleTableViewItem* item   = [group.items objectAtIndex:indexPath.item];

    if (item.deleteBlock)
        return UITableViewCellEditingStyleDelete;
    
    return UITableViewCellEditingStyleNone;
}

#pragma mark - User functions

- (void)reload
{
    [self.tableView reloadData];
}

- (void)clear
{
    [groups removeAllObjects];
    
    [self.tableView reloadData];
}

- (NSArray*)groups
{
    return [groups copy];
}

- (MTSSimpleTableViewGroup*)addGroup
{
    return [self addGroup:nil];
}

- (MTSSimpleTableViewGroup*)addGroup:(NSString*)name
{
    MTSSimpleTableViewGroup* group = [[MTSSimpleTableViewGroup alloc] initWithOwner:self name:name];
    [groups addObject:group];
    
    [self.tableView reloadData];
    
    return group;
}

- (void)updateEnabledStates
{
    for (MTSSimpleTableViewGroup* group in groups)
    {
        for (MTSSimpleTableViewItem* item in group.items)
        {
            [item updateEnabledState];
        }
    }
}

@end
#endif