//
//  UIView+MTSLayout.h
//
//  Created by Roland Rabien on 2013-05-01.
//
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

@interface UIView (MTSLayout)

- (void)layoutHorizontal;
- (void)layoutVeritical;

@end
#endif