//
//  MTSArchiveReader.h
//  LibMTS
//
//  Created by Roland Rabien on 2013-09-03.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface MTSArchiveReader : NSObject {
    NSString* srcPath;
}

+ (MTSArchiveReader*)archiveWriterForPath:(NSString*)path;

- (BOOL)extractToPath:(NSString*)dstPath;

@end
