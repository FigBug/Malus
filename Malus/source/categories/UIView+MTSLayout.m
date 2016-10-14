//
//  UIView+MTSLayout.m
//
//  Created by Roland Rabien on 2013-05-01.
//
//
#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>
#import "UIView+MTSLayout.h"

@implementation UIView (MTSLayout)

- (NSArray*)visibleSubviews
{
    NSMutableArray* visibleViews = [[NSMutableArray alloc] init];
    
    for (UIView* view in [self subviews])
    {
        if (!view.hidden)
            [visibleViews addObject:view];
    }
    return [NSArray arrayWithArray:visibleViews];
}

- (void)layoutHorizontal
{
    NSArray* views = [self visibleSubviews];
    
    CGRect rc = self.bounds;
    
    CGFloat w = rc.size.width;
    CGFloat h = rc.size.height;
    
    double viewWidth = w / views.count;
    
    for (int i = 0; i < views.count; i++)
    {
        CGRect rc = CGRectMake(i * viewWidth, 0, viewWidth, h);
        
        [[views objectAtIndex:i] setFrame:rc];
    }
}

- (void)layoutVeritical
{
    NSArray* views = [self visibleSubviews];
    
    CGRect rc = self.bounds;
    
    CGFloat w = rc.size.width;
    CGFloat h = rc.size.height;
    
    double viewHeight = h / views.count;
    
    for (int i = 0; i < views.count; i++)
    {
        CGRect rc = CGRectMake(0, i * viewHeight, w, viewHeight);
        
        [[views objectAtIndex:i] setFrame:rc];
    }
}

@end
#endif