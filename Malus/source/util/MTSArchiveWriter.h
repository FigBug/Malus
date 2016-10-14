//
//  MTSArchive.h
//  LibMTS
//
//  Created by Roland Rabien on 2013-09-03.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface MTSArchiveWriter : NSObject {
    NSMutableArray* srcFiles;
    NSMutableArray* dstFiles;
    NSString* path;
}

+ (MTSArchiveWriter*)archiveWriterForPath:(NSString*)path;

- (void)addFileWithSourcePath:(NSString*)src;
- (void)addFileWithSourcePath:(NSString*)src destinationPath:(NSString*)dst;

- (BOOL)write;

@end
