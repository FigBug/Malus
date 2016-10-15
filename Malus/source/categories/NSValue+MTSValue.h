//
//  NSValue+MTSValue.h
//  Malus
//
//  Created by Roland Rabien on 2016-01-24.
//  Copyright © 2016 Roland Rabien Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#if ! TARGET_OS_IPHONE
#import <CoreImage/CoreImage.h>

@interface NSValue (MTSValue)

- (CGRect)CGRectValue;
+ (NSValue*)valueWithCGRect:(CGRect)rc;

- (CGPoint)CGPointValue;
+ (NSValue*)valueWithCGPoint:(CGPoint)p;

@end
#endif