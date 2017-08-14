//
//  LZBSegmentConfig.h
//  LZBSegmentBar
//   作者：刘子彬（更多项目源码分享平台“开发者源代码” 微信号：developerCode 作者简介：iOS开发者，喜爱交流分享）
//   如遇到问题或有更好方案，请通过以下方式进行联系，同时可以加入讨论群
//   QQ群：490658347
//   简书：http://www.jianshu.com/u/268ed1ef819e
//   github : https://github.com/lzbgithubcode/LZBSegmentBar
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
 选项卡是不是在导航条上，如果是，就自定义
 */
@property (nonatomic, assign)  BOOL isSegementInNavigationBar;
/**
 是否包含导航条，如果isSegementInNavigationBar 设置，isContainNavigationBar一定等于YES
 */
@property (nonatomic, assign)  BOOL isContainNavigationBar;

/**
 选项卡宽度， isSegementInNavigationBar = yes 有效
 */
@property (nonatomic, assign)  CGFloat segmentBarWidth;

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
