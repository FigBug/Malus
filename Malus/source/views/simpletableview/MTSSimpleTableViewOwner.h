//
//  MTSSimpleTableViewOwner.h
//  Malus
//
//  Created by Roland Rabien on 2016-07-22.
//  Copyright © 2016 Roland Rabien. All rights reserved.
//

@protocol MTSSimpleTableViewOwner <NSObject>

- (void)reload;
- (NSArray*)groups;
- (UITableView*)simpleTableView;
- (void)updateEnabledStates;

@end
