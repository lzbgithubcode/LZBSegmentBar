//
//  LZBSegmentConfig.m
//  LZBSegmentBar
//
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
    return config;
    
}
@end
