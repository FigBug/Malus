//
//  UIAlertView+MTSAlertView.m
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import "UIAlertView+MTSAlertView.h"
#import <objc/runtime.h>

static const char kMTSAlertWrapper;

//=====================================================================================
@interface MTSAlertWrapper : NSObject

@property (copy) void(^completionBlock)(UIAlertView* alertView, NSInteger buttonIndex);

@end

//=====================================================================================
@implementation MTSAlertWrapper

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.completionBlock)
        self.completionBlock(alertView, buttonIndex);
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    if (self.completionBlock)
        self.completionBlock(alertView, alertView.cancelButtonIndex);
}

@end

//=====================================================================================
@implementation UIAlertView (MTSAlertView)

- (void)showWithCompletion:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))completion
{
    MTSAlertWrapper* alertWrapper = [[MTSAlertWrapper alloc] init];
    alertWrapper.completionBlock = completion;
    self.delegate = alertWrapper;
    
    objc_setAssociatedObject(self, &kMTSAlertWrapper, alertWrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self show];
}

@end
#endif