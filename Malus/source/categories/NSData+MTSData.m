//
//  NSData+MTSData.m
//  Malus
//
//  Created by Roland Rabien on 2016-07-28.
//  Copyright © 2016 Motus Design. All rights reserved.
//

#import "NSData+MTSData.h"

@implementation NSData (MTSData)

-(NSString*)hexadecimalString
{
    const unsigned char* dataBuffer = (const unsigned char*)[self bytes];
    
    if (!dataBuffer)
        return [NSString string];
    
    NSUInteger dataLength  = [self length];
    NSMutableString * hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    
    return [NSString stringWithString:hexString];
}

@end
