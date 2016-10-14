//
//  MTSMessageBox.m
//  Malus
//
//  Created by Roland Rabien on 2016-05-12.
//  Copyright © 2016 Motus Design. All rights reserved.
//
#if TARGET_OS_IPHONE

#import "MTSMessageBox.h"
#import <UIKit/UIKit.h>

@implementation MTSMessageBox

+ (void)messageBoxTitle:(NSString*)title message:(NSString*)msg button:(NSString*)button
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:button style:UIAlertActionStyleDefault handler:^(UIAlertAction* action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    [alert addAction:ok];
    
    UIViewController* vc = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}

@end

#endif