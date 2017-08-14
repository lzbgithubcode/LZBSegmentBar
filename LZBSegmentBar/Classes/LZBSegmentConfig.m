//
//  LZBSegmentConfig.m
//  LZBSegmentBar
//   作者：刘子彬（更多项目源码分享平台“开发者源代码” 微信号：developerCode 作者简介：iOS开发者，喜爱交流分享）
//   如遇到问题或有更好方案，请通过以下方式进行联系，同时可以加入讨论群
//   QQ群：490658347
//   简书：http://www.jianshu.com/u/268ed1ef819e
//   github : https://github.com/lzbgithubcode/LZBSegmentBar
//  Created by zibin on 2016/7/16.
//  Copyright © 2016年 lzbgithubcode. All rights reserved.
//

#import "LZBSegmentConfig.h"

@implementation LZBSegmentConfig

+ (instancetype)defaultConfig
{
    LZBSegmentConfig *config = [[LZBSegmentConfig alloc]init];
    config.segmentBarBackColor = [UIColor clearColor];
    config.segmentBarHeight = 44;
    config.itemMargin = 20;
    config.itemNormalColor = [UIColor blackColor];
    config.itemSelectColor = [UIColor redColor];
    config.itemFont = [UIFont systemFontOfSize:14.0];
    config.isScrollEnable = YES;
    config.isShowIndicatorLine = YES;
    config.indicatorLineHeight = 2;
    config.indicatorColor = [UIColor redColor];
    config.isNeedScale = NO;
    config.maxScale = 1.2;
    config.isNeedMask = NO;
    config.maskHeight = 25.0;
    config.maskColor = [UIColor colorWithWhite:0.4 alpha:0.5];
    config.maskLayerRadius = config.maskHeight *0.5;
    config.maskInsetMargin = 10;
    config.isSegementInNavigationBar = NO;
    config.isContainNavigationBar = NO;
    return config;
    
}
@end
