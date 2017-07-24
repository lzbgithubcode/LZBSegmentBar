//
//  LZBSegmentConfig.h
//  LZBSegmentBar
//
//  Created by zibin on 2016/7/16.
//  Copyright © 2016年 lzbgithubcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZBSegmentConfig : NSObject
/**
 初始化，设置默认值

 @return  实例化默认配置
 */
+ (instancetype)defaultConfig;

/**
  标题栏默认高度 44
 */
@property (nonatomic, assign) CGFloat segmentBarHeight;

/**
 标题栏默认背景颜色
 */
@property (nonatomic, strong) UIColor *segmentBarBackColor;

/**
  标题默认正常颜色
 */
@property (nonatomic, strong) UIColor *itemNormalColor;
/**
  标题默认选中颜色
 */
@property (nonatomic, strong) UIColor *itemSelectColor;
/**
 标题栏默认字体 14.0
 */
@property (nonatomic, strong) UIFont *itemFont;

/**
 默认间距 20.0
 */
@property (nonatomic, assign) CGFloat itemMargin;

/**
 默认不可以滚动 NO
 */
@property (nonatomic, assign) BOOL isScrollEnable;



/**
   是否显示底部线
 */
@property (nonatomic, assign) BOOL isShowIndicatorLine;

/**
  底部线的默认高度 2.0 isShowIndicatorLine =YES有效
 */
@property (nonatomic, assign) CGFloat indicatorLineHeight;

/**
 底部线默认颜色 isShowIndicatorLine =YES有效
 */
@property (nonatomic, strong) UIColor *indicatorColor;



/**
 是否需要放大
 */
@property (nonatomic, assign) BOOL isNeedScale;

/**
 缩放的最大值 isNeedScale =YES有效
 */
@property (nonatomic, assign) CGFloat maxScale;



/**
 是否需要遮罩
 */
@property (nonatomic, assign) BOOL isNeedMask;

/**
 遮罩内部间距 10.0  isNeedMask =YES有效
 */
@property (nonatomic, assign) CGFloat maskInsetMargin;

/**
 遮罩高度  isNeedMask =YES有效
 */
@property (nonatomic, assign) CGFloat maskHeight;
/**
 遮罩圆角  isNeedMask =YES有效
 */
@property (nonatomic, assign) CGFloat maskLayerRadius;

/**
 遮罩圆角  isNeedMask =YES有效
 */
@property (nonatomic, strong) UIColor *maskColor;

@end
