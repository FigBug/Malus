//
//  MTSCPUMeter.m
//  MTS
//
//  Created by Roland Rabien on 2013-09-11.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "MTSCPUMeter.h"
#import <mach/mach.h>
#import "../../util/MTSTimer.h"

@implementation MTSCPUMeter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        timer = [MTSTimer repeatingTimerWithTimeInterval:1.0 callingBlock:^(MTSTimer* timer)
                 {
                     double cpu = [self cpuUsage];
                     [self setText:[NSString stringWithFormat:@"%d%%", (int)(cpu + 0.5)]];
                 }];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        timer = [MTSTimer repeatingTimerWithTimeInterval:1.0 callingBlock:^(MTSTimer* timer)
                 {
                     double cpu = [self cpuUsage];
                     [self setText:[NSString stringWithFormat:@"%d%%", (int)(cpu + 0.5)]];
                 }];
    }
    return self;
}

- (double)cpuUsage
{
    task_info_data_t tinfo;
    
    mach_msg_type_number_t task_info_count = TASK_INFO_MAX;
    kern_return_t kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS)
        return -1;
    
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    
    thread_basic_info_t basic_info_th;
    
    // get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS)
        return -1;
    
    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    
    for (int j = 0; j < thread_count; j++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO, (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS)
            return -1;
        
        basic_info_th = (thread_basic_info_t)thinfo;
        
        if (!(basic_info_th->flags & TH_FLAGS_IDLE))
        {
            tot_sec     = tot_sec  + basic_info_th->user_time.seconds        + basic_info_th->system_time.seconds;
            tot_usec    = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu     = tot_cpu  + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }
        
    } // for each thread
    
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);
    
    return tot_cpu;
}

@end
#endif