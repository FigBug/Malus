//
//  NSDate+MTSDate.h
//  MTS
//
//  Created by Roland Rabien on 2013-09-16.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MTSDate)

+ (NSDate*)dateWithXSDDateTime:(NSString*)dateTime;
- (NSString*)stringWithFileSystemSafeDateTime;

@end
