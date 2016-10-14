//
//  MTSVideoUtil.m
//
//  Created by Roland Rabien on 2012-12-03.
//  Copyright (c) 2012 Roland Rabien. All rights reserved.
//

#import "MTSVideoUtil.h"
#import "MTSUtil.h"
#import "MTSLog.h"

@implementation MTSVideoUtil

+ (BOOL)trim:(NSString*)fileIn start:(double)start length:(double)length done:(void(^)(BOOL ok))done
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileIn])
    {
        MTSLog(@"File to be trimmed missing");
        return NO;
    }
    
    NSTimeInterval t0 = [NSDate timeIntervalSinceReferenceDate];
    
    NSString* fileOut = [fileIn stringByAppendingString:@".tmp"];
    
    NSURL* urlIn  = [NSURL fileURLWithPath:fileIn];
    NSURL* urlOut = [NSURL fileURLWithPath:fileOut];
    
    AVAsset* assetIn = [AVAsset assetWithURL:urlIn];
    
    MTSLog(@"Trim from %.2f to %.2f of %.2f", start, start + length, CMTimeGetSeconds([assetIn duration]));
    
    AVAssetExportSession* exportSession = [[AVAssetExportSession alloc] initWithAsset:assetIn presetName:AVAssetExportPresetPassthrough];
    
    exportSession.outputURL = urlOut;
    exportSession.outputFileType = AVFileTypeQuickTimeMovie;
    
    CMTime t = CMTimeMakeWithSeconds(start, 600);
    CMTime d = CMTimeMakeWithSeconds(length, 600);
    CMTimeRange range = CMTimeRangeMake(t, d);
    exportSession.timeRange = range;
    
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
    
        if ([exportSession status] != AVAssetExportSessionStatusCompleted)
        {
            NSError* e = [exportSession error];
            if (e)
                MTSLog(@"export error: %@", [e localizedDescription]);
            
            if (done)
                done(NO);
        }
        else
        {
            NSError* e1 = nil;
            NSError* e2 = nil;
            
            [[NSFileManager defaultManager] removeItemAtPath:fileIn error:&e1];
            if (e1)
                MTSLog(@"Trim delete error: %@", [e1 localizedDescription]);
            
            [[NSFileManager defaultManager] moveItemAtPath:fileOut toPath:fileIn error:&e2];
            if (e2)
                MTSLog(@"Trim move error: %@", [e2 localizedDescription]);
            
            NSTimeInterval t1 = [NSDate timeIntervalSinceReferenceDate];
            
            MTSLog(@"Video trimmed in %.2fs", t1 - t0);
            
            if (done)
                done(YES);
        }
    }];
    
    return YES;
}

#if TARGET_OS_IPHONE
+ (BOOL)generateThumbnail:(NSString*)videoPath done:(void(^)(UIImage* thumb))done
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:videoPath])
    {
        MTSLog(@"Non existant video file: %@", videoPath);
        return NO;
    }
    
    AVURLAsset* asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoPath] options:nil];
    
    AVAssetImageGenerator* generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    generator.appliesPreferredTrackTransform = TRUE;
    
    CMTime thumbTime = CMTimeMakeWithSeconds(0,30);
    
    AVAssetImageGeneratorCompletionHandler handler = ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error)
    {
        if (result != AVAssetImageGeneratorSucceeded)
        {
            MTSLog(@"couldn't generate thumbnail, error:%@", error);
        }
        else
        {
            if (done)
                done([UIImage imageWithCGImage:im]);
        }
    };
    
    CGSize maxSize = CGSizeMake(320, 320);
    generator.maximumSize = maxSize;
    [generator generateCGImagesAsynchronouslyForTimes:[NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:handler];

    return YES;
}
#endif

@end
