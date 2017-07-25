//
//  UIColor+LZBSegmentColorExtension.h
//  LZBSegmentBar
//   作者：刘子彬（更多项目源码分享平台“开发者源代码” 微信号：developerCode 作者简介：iOS开发者，喜爱交流分享）
//   如遇到问题或有更好方案，请通过以下方式进行联系，同时可以加入讨论群
//   QQ群：490658347
//   简书：http://www.jianshu.com/u/268ed1ef819e
//   github : https://github.com/lzbgithubcode/LZBSegmentBar
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
