//
//  MTSUtil.h
//
//  Created by Roland Rabien on 2012-08-22.
//  Copyright (c) 2012 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#endif

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface MTSUtil : NSObject

+ (NSString*)formatTime:(double)time withHours:(BOOL)alwaysShowHours andMilliseconds: (BOOL)showMilli;
+ (NSString*)formatTime:(double)time withHours:(BOOL)alwaysShowHours andTenths: (BOOL)showTenths;

+ (NSString*)pathForTemporaryFileWithPrefix:(NSString *)prefix;

+ (NSString*)createUUID;

+ (uint64_t)totalDiskspace;
+ (uint64_t)freeDiskspace;

+ (unsigned long long int)folderSize:(NSString *)folderPath;
+ (unsigned long long int)fileSize:(NSString*)filePath;

+ (NSString*)formatFileSize:(unsigned long long int)value;

#if TARGET_OS_IPHONE
+ (UIImage*)resizedImage:(UIImage*)inImage rect:(CGRect)thumbRect;
+ (UIImage*)squareImage:(UIImage*)inImage;
#endif

+ (NSString*)sanitizeFileNameString:(NSString *)fileName;

+ (void)purgeDirectory:(NSString*)path;

+ (void)from:(double)v toQ16:(unsigned int*)m _8:(unsigned char*)f;
+ (double)fromQ16:(unsigned int)m _8:(unsigned char)f;

+ (NSString*)fileNameSafe:(NSString*)str;

+ (BOOL)encodeObject:(id<NSCoding>)object toFile:(NSString*)fileName;
+ (id)decodeObjectFromFile:(NSString*)fileName;

@end
