//
//  LZBSegmentBarViewController.h
//  LZBSegmentBar
//
//  Created by zibin on 2017/8/14.
//  Copyright © 2017年 lzbgithubcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZBSegmentBar.h"

@interface LZBSegmentBarViewController : UIViewController


/**
 自定义segmentBar的父类。如果没有设置就增加到LZBSementBarViewController，用于设置到导航条上的bar
 */
@property (nonatomic, strong) LZBSegmentBar *segmentBar;


/**
 初始化控制器

 @param config 配置模型
 @param items 标题数组
 @param childVCs 子控制数组
 @return 控制器
 */
- (instancetype)initWithSegmentConfig:(LZBSegmentConfig *)config items:(NSArray<NSString *> *)items childVCs:(NSArray<UIViewController *> *)childVCs;

/**
 更新frame
 
 @param udpateFrame 设置更新frame
 */
- (void)updateFrameWithLayoutSubViews:(CGRect)udpateFrame;
@end
