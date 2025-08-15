//
//  MTSMessageBox.h
//  Malus
//
//  Created by Roland Rabien on 2016-05-12.
//  Copyright © 2016 Roland Rabien. All rights reserved.
//
#if TARGET_OS_IPHONE

#import <Foundation/Foundation.h>

@interface MTSMessageBox : NSObject

+ (void)messageBoxTitle:(NSString*)title message:(NSString*)msg button:(NSString*)button;

@end

#endif
