//
//  MTSArchiveReader.m
//  LibMTS
//
//  Created by Roland Rabien on 2013-09-03.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#if TARGET_OS_IPHONE
#import "MTSArchiveReader.h"
#import "archive.h"
#import "archive_entry.h"

@implementation MTSArchiveReader

+ (MTSArchiveReader*)archiveWriterForPath:(NSString*)path
{
    MTSArchiveReader* reader = [[MTSArchiveReader alloc] init];
    reader->srcPath = [path copy];
    return reader;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        srcPath = @"";
    }
    return self;
}

- (BOOL)extractToPath:(NSString*)dstPath
{
    int r;
    __LA_SSIZE_T size;
    
    NSFileManager* fm = [NSFileManager defaultManager];
    
    struct archive* a = archive_read_new();
    struct archive_entry* ae;
    
    archive_read_support_compression_all(a);
    archive_read_support_format_all(a);
    
    r = archive_read_open_filename(a, [srcPath UTF8String], 64 * 1024);
    if (r != ARCHIVE_OK)
        return NO;
    
    while (archive_read_next_header(a, &ae) == ARCHIVE_OK)
    {
        char buff[64 * 1024];
        
        NSString* outputPath = [dstPath stringByAppendingPathComponent: [NSString stringWithUTF8String: archive_entry_pathname(ae)]];
        
        [fm createDirectoryAtPath:[outputPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
        
        FILE* fp = fopen([outputPath UTF8String], "w");
        if (fp)
        {
            while ((size = archive_read_data(a, buff, sizeof(buff))) != 0)
            {
                if (size == ARCHIVE_FATAL)
                {
                    fclose(fp);
                    archive_read_close(a);
                    archive_read_finish(a);
                    return  NO;
                }
                
                fwrite(buff, size, 1, fp);
            }
            fclose(fp);
        }
    }
    
    archive_read_close(a);
    archive_read_finish(a);
    
    return YES;
}

@end
#endif
