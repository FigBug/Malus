//
//  MTSActionSheet.m
//  Malus
//
//  Created by Roland Rabien on 2016-05-12.
//  Copyright © 2016 Motus Design. All rights reserved.
//
#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>
#import "MTSActionSheet.h"

MTSActionSheet* retain;

@implementation MTSActionSheet

- (id)initWithTitle:(NSString*)title viewController:(UIViewController*)vc_
{
    self = [super init];
    if (self)
    {
        actionSheet = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        vc = vc_;
    }
    retain = self;
    return self;
}

- (void)addAction:(NSString*)title completion:(void (^)())completetion
{
    UIAlertAction* action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction* action)
                             {
                                 completetion();
                                 [vc dismissViewControllerAnimated:YES completion:nil];
                             }];
    [actionSheet addAction:action];
}

- (void)addDeleteAction:(NSString*)title completion:(void (^)())completetion
{
    UIAlertAction* action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:^(UIAlertAction* action)
                             {
                                 completetion();
                                 [vc dismissViewControllerAnimated:YES completion:nil];
                             }];
    [actionSheet addAction:action];
}

- (void)showAt:(UIBarButtonItem*)button;
{
    bool iPhone = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
    if (iPhone)
    {
        UIAlertAction* action = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action)
        {
            [vc dismissViewControllerAnimated:YES completion:nil];
        }];
        [actionSheet addAction:action];
    }
    
    actionSheet.popoverPresentationController.barButtonItem = button;
    [vc presentViewController:actionSheet animated:YES completion:nil];
}

- (void)showFromView:(UIView*)view
{
    bool iPhone = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
    if (iPhone)
    {
        UIAlertAction* action = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action)
                                 {
                                     [vc dismissViewControllerAnimated:YES completion:nil];
                                 }];
        [actionSheet addAction:action];
    }
    
    actionSheet.popoverPresentationController.sourceView = view;
    [vc presentViewController:actionSheet animated:YES completion:nil];
}

@end

#endif