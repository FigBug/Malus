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

void MTSLogOpen(void);
    
void MTSLogClose(void);
    
void MTSLogClear(void);
    
void MTSLog(NSString* format, ...);

#ifdef __cplusplus
}
#endif
