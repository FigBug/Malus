//
//  MTSLog.h
//
//  Created by Roland Rabien on 2013-06-04.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#ifdef __cplusplus
extern "C" {
#endif
    
#import <Foundation/Foundation.h>

void MTSLogOpen();
    
void MTSLogClose();
    
void MTSLogClear();
    
void MTSLog(NSString* format, ...);

#ifdef __cplusplus
}
#endif