//
//  MTSTimer.m
//  MTS
//
//  Created by Roland Rabien on 2013-09-05.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#import "MTSTimer.h"
#import "MTSMacros.h"

static NSMutableArray* timerList = nil;

@implementation MTSTimer

+ (void)disableTimers
{
    if (!timerList)
        return;
    
    for (MTSTimer* timer in timerList)
    {
        if (timer->timer)
        {
            [timer->timer invalidate];
            timer->timer = nil;
        }
    }
}

+ (void)enableTimers
{
    if (!timerList)
        return;

    for (MTSTimer* timer in timerList)
    {
        if (!timer->timer)
            timer->timer = [NSTimer timerWithTimeInterval:timer->interval target:timer selector:@selector(timerFired:) userInfo:nil repeats:timer->repeats];
    }
}

+ (MTSTimer*)repeatingTimerWithTimeInterval:(NSTimeInterval)seconds callingBlock:(void(^)(MTSTimer*))block
{
    MTSTimer* t     = [[MTSTimer alloc] init];
    
    t->timer        = [NSTimer timerWithTimeInterval:seconds target:t selector:@selector(timerFired:) userInfo:nil repeats:YES];
    t->timerBlock   = block;
    t->interval     = seconds;
    t->repeats      = YES;

    
    [[NSRunLoop mainRunLoop] addTimer:t->timer forMode:NSDefaultRunLoopMode];
    
    return t;
}

+ (MTSTimer*)nonRepeatingTimerWithTimeInterval:(NSTimeInterval)seconds callingBlock:(void(^)(MTSTimer*))block
{
    MTSTimer* t     = [[MTSTimer alloc] init];
    
    t->timer        = [NSTimer timerWithTimeInterval:seconds target:t selector:@selector(timerFired:) userInfo:nil repeats:NO];
    t->timerBlock   = block;
    t->interval     = seconds;
    t->repeats      = NO;

    
    [[NSRunLoop mainRunLoop] addTimer:t->timer forMode:NSDefaultRunLoopMode];
    
    return t;
}

+ (MTSTimer*)repeatingTimerWithTimeInterval:(NSTimeInterval)seconds target:(id)target selector:(SEL)selector
{
    MTSTimer* t = [[MTSTimer alloc] init];
    
    t->timer    = [NSTimer timerWithTimeInterval:seconds target:t selector:@selector(timerFired:) userInfo:nil repeats:YES];
    t->selector = selector;
    t->target   = target;
    t->interval = seconds;
    t->repeats  = YES;
    
    [[NSRunLoop mainRunLoop] addTimer:t->timer forMode:NSDefaultRunLoopMode];
    
    return t;
}

+ (MTSTimer*)nonRepeatingTimerWithTimeInterval:(NSTimeInterval)seconds target:(id)target selector:(SEL)selector
{
    MTSTimer* t = [[MTSTimer alloc] init];
    
    t->timer    = [NSTimer timerWithTimeInterval:seconds target:t selector:@selector(timerFired:) userInfo:nil repeats:NO];
    t->selector = selector;
    t->target   = target;
    t->interval = seconds;
    t->repeats  = NO;
    
    [[NSRunLoop mainRunLoop] addTimer:t->timer forMode:NSDefaultRunLoopMode];
    
    return t;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        if (!timerList)
            timerList = [[NSMutableArray alloc] init];
        
        [timerList addObject:self];
    }
    return self;
}

- (void)invalidate
{
    [timerList removeObject:self];
    
    [timer invalidate];
    timer = nil;
}

- (void)timerFired:(NSTimer*)timer
{
    if (!repeats)
        [timerList removeObject:self];
    
    if (timerBlock)
    {
        timerBlock(self);
    }
    else if (target && selector)
    {
        MTSSuppressPerformSelectorLeakWarning([target performSelector:selector withObject:self]);
    }
}

@end
