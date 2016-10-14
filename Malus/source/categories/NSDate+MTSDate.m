//
//  NSDate+MTSDate.m
//  MTS
//
//  Created by Roland Rabien on 2013-09-16.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#import "NSDate+MTSDate.h"

@implementation NSDate (MTSDate)

+ (NSDate*)dateWithXSDDateTime:(NSString*)dateTime
{
    static NSDateFormatter* xsdDateTimeFormatter;
    if (!xsdDateTimeFormatter)
    {
        xsdDateTimeFormatter            = [[NSDateFormatter alloc] init];  // Keep around forever
        xsdDateTimeFormatter.timeStyle  = NSDateFormatterFullStyle;
        xsdDateTimeFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:sszzz";
    }
    
    // Date formatters don't grok a single trailing Z, so make it "GMT".
    if ([dateTime hasSuffix: @"Z"])
        dateTime = [[dateTime substringToIndex: dateTime.length - 1] stringByAppendingString: @"GMT"];
    
    NSDate* date = [xsdDateTimeFormatter dateFromString:dateTime];
    
    return date;
}

- (NSString*)stringWithFileSystemSafeDateTime
{
    static NSDateFormatter* dateTimeFormatter;
    if (!dateTimeFormatter)
    {
        dateTimeFormatter            = [[NSDateFormatter alloc] init];  // Keep around forever
        dateTimeFormatter.timeStyle  = NSDateFormatterFullStyle;
        dateTimeFormatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    }

    return [dateTimeFormatter stringFromDate:self];
}

@end
