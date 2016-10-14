//
//  MTSUtil.m
//
//  Created by Roland Rabien on 2012-08-22.
//  Copyright (c) 2012 Roland Rabien. All rights reserved.
//

#import "MTSUtil.h"
#import "MTSDefaults.h"

#define kEncodedObject  @"encodedObject"

@implementation MTSUtil

+ (NSString*)formatTime:(double)time withHours: (BOOL)alwaysShowHours andMilliseconds: (BOOL)showMilli
{
    bool negative = time < 0;
    time = fabs(time);
    
    char buffer[1024];
    if (time > 3599 || alwaysShowHours)
    {
        int intTime = time;
        int hours = intTime / 3600;
        sprintf(buffer, "%s%d:%.2d:%.2d", negative ? "-" : "", hours, (intTime - (3600 * hours)) / 60, intTime % 60);
    }
    else
    {
        int intTime = time;
        sprintf(buffer, "%s%d:%.2d", negative ? "-" : "", intTime / 60, intTime % 60);
    }
    
    NSString* res;
    
    if (showMilli)
    {
        double intPart;
        
        double m = modf(time, &intPart) * 1000;
        int milli = (int)(m + 0.5);
        sprintf(buffer + strlen(buffer), ".%.3d", milli);
    }
    
    res = [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
    
    return res;
}

+ (NSString*)formatTime:(double)time withHours:(BOOL)alwaysShowHours andTenths: (BOOL)showTenths
{
    bool negative = time < 0;
    time = fabs(time);
    
    char buffer[1024];
    if (time > 3599 || alwaysShowHours)
    {
        int intTime = time;
        int hours = intTime / 3600;
        sprintf(buffer, "%s%d:%.2d:%.2d", negative ? "-" : "", hours, (intTime - (3600 * hours)) / 60, intTime % 60);
    }
    else
    {
        int intTime = time;
        sprintf(buffer, "%s%d:%.2d", negative ? "-" : "", intTime / 60, intTime % 60);
    }
    
    NSString* res;
    
    if (showTenths)
    {
        double intPart;
        
        double m = modf(time, &intPart) * 1000;
        int milli = (int)(m);
        sprintf(buffer + strlen(buffer), ".%d", milli / 100);
    }
    
    res = [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
    
    return res;
}

+ (NSString*)pathForTemporaryFileWithPrefix:(NSString *)prefix
{
    NSString *  result;
    CFUUIDRef   uuid;
    CFStringRef uuidStr;
    
    uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    assert(uuidStr != NULL);
    
    result = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@", prefix, uuidStr]];
    assert(result != nil);
    
    CFRelease(uuidStr);
    CFRelease(uuid);
    
    return result;
}

+ (NSString*)createUUID
{
    NSString* res;
    
    CFUUIDRef   uuid;
    CFStringRef uuidStr;
    
    uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    assert(uuidStr != NULL);
    
    res = (__bridge NSString*)uuidStr;
    
    CFRelease(uuidStr);
    CFRelease(uuid);
    
    return res;
}

+ (uint64_t)totalDiskspace
{
    uint64_t totalSpace     = 0;
   
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary* dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: nil];
    
    if (dictionary)
    {
        NSNumber* fileSystemSizeInBytes     = [dictionary objectForKey:NSFileSystemSize];
        
        totalSpace =     [fileSystemSizeInBytes unsignedLongLongValue];
    }
    return totalSpace;
}

+ (uint64_t)freeDiskspace
{
    uint64_t totalFreeSpace = 0;
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary* dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: nil];
    
    if (dictionary)
    {
        NSNumber* freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
    }
    return totalFreeSpace;
}

+ (unsigned long long int)folderSize:(NSString *)folderPath
{
    unsigned long long int fileSize = 0;

    BOOL isDir = NO;
    
    NSArray* subpaths;
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:folderPath isDirectory:&isDir] && isDir)
    {
        subpaths = [fileManager subpathsAtPath:folderPath];
        
        for (NSString* path in subpaths)
        {
            NSString* filePath = [folderPath stringByAppendingPathComponent:path];
            NSDictionary* attr = [fileManager attributesOfItemAtPath:filePath error:nil];
            if ([[attr valueForKey:NSFileType] isEqualToString:NSFileTypeRegular])
                fileSize += [[attr valueForKey:NSFileSize] longLongValue];
        }
    }

    return fileSize;
}

+ (unsigned long long int)fileSize:(NSString*)filePath
{
    NSDictionary* attr = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];

    if ([[attr valueForKey:NSFileType] isEqualToString:NSFileTypeRegular])
        return [[attr valueForKey:NSFileSize] longLongValue];
    
    return 0;
}

+ (NSString*)formatFileSize:(unsigned long long int)value
{
    double convertedValue = value;
    
    int multiplyFactor = 0;
    
    NSArray* tokens = [NSArray arrayWithObjects:@"Bytes", @"KB", @"MB", @"GB", @"TB", nil];
    
    while (convertedValue > 1000)
    {
        convertedValue /= 1000;
        multiplyFactor++;
    }
    
    NSString* res = [NSString stringWithFormat:@"%.1f %@", convertedValue, [tokens objectAtIndex:multiplyFactor]];
    return res;
}

#if TARGET_OS_IPHONE
+ (UIImage*)resizedImage:(UIImage*)inImage rect:(CGRect)thumbRect
{
    CGImageRef			imageRef = [inImage CGImage];
    CGImageAlphaInfo	alphaInfo = CGImageGetAlphaInfo(imageRef);
    
    if (alphaInfo == kCGImageAlphaNone)
    	alphaInfo = kCGImageAlphaNoneSkipLast;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmap = CGBitmapContextCreate (NULL, thumbRect.size.width, thumbRect.size.height, 8, thumbRect.size.width * 3, colorSpace, (CGBitmapInfo)alphaInfo);
    
    CGContextDrawImage(bitmap, thumbRect, imageRef);
    
    CGImageRef	ref = CGBitmapContextCreateImage(bitmap);
    UIImage*	result = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    CGColorSpaceRelease(colorSpace);
    
    return result;
}

+ (UIImage*)squareImage:(UIImage*)inImage
{
    CGSize sz = [inImage size];
    int dim = sz.width < sz.height ? sz.width : sz.height;
    
    CGRect rc = CGRectMake(sz.width / 2 - dim / 2, sz.height / 2 - dim / 2,dim , dim);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([inImage CGImage], rc);
    UIImage *result = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return result;
}
#endif

+ (NSString*)sanitizeFileNameString:(NSString*)fileName
{
    NSCharacterSet* illegalFileNameCharacters = [NSCharacterSet characterSetWithCharactersInString:@"/\\?%*|\"<>"];
    return [[fileName componentsSeparatedByCharactersInSet:illegalFileNameCharacters] componentsJoinedByString:@""];
}

+ (void)purgeDirectory:(NSString*)path
{
    NSArray* contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString* file in contents)
        [[NSFileManager defaultManager] removeItemAtPath:[path stringByAppendingPathComponent:file] error:nil];
}

+ (void)from:(double)v toQ16:(unsigned int*)m _8:(unsigned char*)f
{
    *m = (unsigned short)fabs(v);
    *f = (unsigned char)(fabs(v) * 256.0);
    if (v < 0) *m |= 0x8000;
}

+ (double)fromQ16:(unsigned int)m _8:(unsigned char)f
{
    double v = (m & 0x7FFF) + f / 256.0;
    if (m & 0x8000) v = -v;
    return v;
}

+ (NSString*)fileNameSafe:(NSString*)str
{
    NSCharacterSet* illegalFileNameCharacters = [NSCharacterSet characterSetWithCharactersInString:@"/\\?%*|\"<>"];
    return [[str componentsSeparatedByCharactersInSet:illegalFileNameCharacters] componentsJoinedByString:@""];
}

+ (BOOL)encodeObject:(id<NSCoding>)object toFile:(NSString *)fileName
{
    NSMutableData* data = [[NSMutableData alloc] init];
    
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver setOutputFormat:NSPropertyListBinaryFormat_v1_0];
    
    [archiver encodeObject: object forKey:kEncodedObject];
    [archiver finishEncoding];
    
    if ([data writeToFile: fileName atomically:YES])
        return YES;
    else
        return NO;
}

+ (id)decodeObjectFromFile:(NSString*)fileName
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName])
    {
        NSData* data = [NSData dataWithContentsOfFile:fileName];        
        if (data)
        {
            NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            if (unarchiver)
            {
                @try
                {
                    return [unarchiver decodeObjectForKey:kEncodedObject];
                }
                @catch (NSException* exception)
                {
                    NSLog(@"%@", exception);
                    return nil;
                }
            }
        }
    }
    return nil;
}

@end
