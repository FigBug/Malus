//
//  MTSTimer.h
//  MTS
//
//  Created by Roland Rabien on 2013-09-05.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTSTimer : NSObject {
    NSTimer* timer;
    
    void (^timerBlock)(MTSTimer* timer);
    SEL selector;
    id target;
    
    NSTimeInterval interval;
    BOOL repeats;
}

+ (MTSTimer*)repeatingTimerWithTimeInterval:(NSTimeInterval)seconds callingBlock:(void(^)(MTSTimer*))block;
+ (MTSTimer*)nonRepeatingTimerWithTimeInterval:(NSTimeInterval)seconds callingBlock:(void(^)(MTSTimer*))block;

+ (MTSTimer*)repeatingTimerWithTimeInterval:(NSTimeInterval)seconds target:(id)target selector:(SEL)selector;
+ (MTSTimer*)nonRepeatingTimerWithTimeInterval:(NSTimeInterval)seconds target:(id)target selector:(SEL)selector;

- (void)invalidate;

+ (void)disableTimers;
+ (void)enableTimers;

@end
