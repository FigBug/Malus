//
//  MTSArchive.m
//  LibMTS
//
//  Created by Roland Rabien on 2013-09-03.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#if TARGET_OS_IPHONE
#import "MTSArchiveWriter.h"
#import "archive.h"
#import "archive_entry.h"

@implementation MTSArchiveWriter

+ (MTSArchiveWriter*)archiveWriterForPath:(NSString*)path
{
    MTSArchiveWriter* writer = [[MTSArchiveWriter alloc] init];
    writer->path = [path copy];
    return writer;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        path     = @"";
        srcFiles = [[NSMutableArray alloc] init];
        dstFiles = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addFileWithSourcePath:(NSString*)src
{
    [self addFileWithSourcePath:src destinationPath:[src lastPathComponent]];
}

- (void)addFileWithSourcePath:(NSString*)src destinationPath:(NSString*)dst
{
    [srcFiles addObject:src];
    [dstFiles addObject:dst];
}

- (BOOL)write
{
    struct archive *a;
    struct archive_entry *entry;
    struct stat st;
    char buff[8192];
    size_t len;
    FILE* fp;
    
    a = archive_write_new();
    archive_write_set_compression_gzip(a);
    archive_write_set_format_ustar(a);
    
    archive_write_open_filename(a, [path UTF8String]);
    
    for (NSString* filename in srcFiles)
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:filename])
        {
            stat([filename UTF8String], &st);
            entry = archive_entry_new(); // Note 2
            archive_entry_set_pathname(entry, [[filename lastPathComponent] UTF8String]);
            archive_entry_set_size(entry, st.st_size); // Note 3
            archive_entry_set_filetype(entry, AE_IFREG);
            archive_entry_set_perm(entry, 0644);
            archive_write_header(a, entry);
            
            fp = fopen([filename UTF8String], "rb");
            if (fp)
            {
                len = fread(buff, 1, sizeof(buff), fp);
                while ( len > 0 )
                {
                    archive_write_data(a, buff, len);
                    len = fread(buff, 1, sizeof(buff), fp);
                }
                fclose(fp);
            }
            archive_entry_free(entry);
        }
    }
    archive_write_close(a); // Note 4
    archive_write_finish(a); // Note 5
    
    return YES;
}

@end
#endif