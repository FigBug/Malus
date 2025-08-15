//
//  MTSActionSheet.h
//  Malus
//
//  Created by Roland Rabien on 2016-05-12.
//  Copyright © 2016 Roland Rabien. All rights reserved.
//
#if TARGET_OS_IPHONE

#import <Foundation/Foundation.h>

@interface MTSActionSheet : NSObject {
    UIAlertController* actionSheet;
    UIViewController* vc;
}

- (id)initWithTitle:(NSString*)title viewController:(UIViewController*)vc;
- (void)addAction:(NSString*)title completion:(void (^)())completetion;
- (void)addDeleteAction:(NSString*)title completion:(void (^)())completetion;
- (void)showAt:(UIBarButtonItem*)button;
- (void)showFromView:(UIView*)view;

@end

#endif
