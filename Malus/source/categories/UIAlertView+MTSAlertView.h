//
//  UIAlertView+MTSAlertView.h
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

@interface UIAlertView (MTSAlertView)

- (void)showWithCompletion:(void(^)(UIAlertView* alertView, NSInteger buttonIndex))completion;

@end
#endif