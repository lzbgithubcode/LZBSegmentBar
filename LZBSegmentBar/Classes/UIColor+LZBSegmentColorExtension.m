//
//  UIColor+LZBSegmentColorExtension.m
//  LZBSegmentBar
//
//  Created by zibin on 2016/7/16.
//  Copyright © 2016年 lzbgithubcode. All rights reserved.
//

#import "UIColor+LZBSegmentColorExtension.h"

@implementation UIColor (LZBSegmentColorExtension)

+ (UIColor *)getRandomColor
{
    CGFloat r = arc4random_uniform(255)/255.0;
    CGFloat g = arc4random_uniform(255)/255.0;
    CGFloat b = arc4random_uniform(255)/255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}
- (CGFloat)getRGBValueR
{
     return [[[self getRGBValue] objectAtIndex:0] floatValue];
    
}
- (CGFloat)getRGBValueG
{
     return [[[self getRGBValue] objectAtIndex:1] floatValue];
}

- (CGFloat)getRGBValueB
{
    return [[[self getRGBValue] objectAtIndex:2] floatValue];
}

- (NSArray *)getRGBValue
{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red),@(green),@(blue),@(alpha)];
}
@end
