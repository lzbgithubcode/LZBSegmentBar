//
//  UIColor+LZBSegmentColorExtension.h
//  LZBSegmentBar
//
//  Created by zibin on 2016/7/16.
//  Copyright © 2016年 lzbgithubcode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LZBSegmentColorExtension)
/**
 获取随机颜色

 @return 随机颜色
 */
+ (UIColor *)getRandomColor;

/**
 获取RGB值的R

 @return  返回R的值
 */
- (CGFloat)getRGBValueR;

/**
 获取RGB值的G
 
 @return 返回G的值
 */
- (CGFloat)getRGBValueG;

/**
 获取RGB值的B
 
 @return 返回B的值
 */
- (CGFloat)getRGBValueB;

/**
 获取RGB值
 
 @return 返回RGB的值
 */
- (NSArray *)getRGBValue;


@end
