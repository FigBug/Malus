//
//  NSFileManager+MTSFileManager.m
//  MTS
//
//  Created by Roland Rabien on 10/29/2013.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#import "NSFileManager+MTSFileManager.h"

@implementation NSFileManager (MTSFileManager)

- (NSString*)pathForDocuments
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    [self createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    return documentsDirectory;
}

@end
