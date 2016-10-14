//
//  MTSMacros.h
//  MTS
//
//  Created by Roland Rabien on 2013-09-05.
//  Copyright (c) 2013 Roland Rabien. All rights reserved.
//

#define MTSSuppressPerformSelectorLeakWarning(x) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        x; \
        _Pragma("clang diagnostic pop") \
    } while (0)

#define BOUNDED(lo, hi, value) (value < lo ? lo : (value > hi ? hi : value))

#define FIXDOUBLE(x) ((isnan(x) || isinf(x)) ? 0 : x)