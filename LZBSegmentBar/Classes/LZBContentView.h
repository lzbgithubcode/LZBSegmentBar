//
//  LZBContentView.h
//  LZBSegmentBar
//
//  Created by zibin on 2016/7/16.
//  Copyright © 2016年 lzbgithubcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZBSegmentConfig.h"
@class LZBContentView;

@protocol  LZBContentViewDelegate<NSObject>


/**
 代理监听滚动结束

 @param contenView 滚动的contenView
 @param index 滚动结束的索引
 */
- (void)conentView:(LZBContentView *)contenView didScrollEndIndex:(NSInteger)index;

/**
 代理监听滚动过程

 @param contenView 滚动的contenView
 @param sourceIndex 滚动开始的位置
 @param targetIndex 滚动结束的位置
 @param progress 滚动进度
 */
- (void)conentView:(LZBContentView *)contenView sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress;

@end

@interface LZBContentView : UIView

/**
 滚动监听代理
 */
@property (nonatomic, weak) id<LZBContentViewDelegate> delegate;

/**
 初始化LZBContentView

 @param frame frame
 @param childVcs 子控制器
 @param parentVc 父控制器
 @param config 配置model
 @return 返回实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray <UIViewController *>*)childVcs parentVc:(UIViewController *)parentVc config:(LZBSegmentConfig *)config;



/**
 标题栏选中那个目标index

 @param targetIndex 目标选中index
 */
- (void)segmentDidSelectTargetIndex:(NSInteger)targetIndex;
@end
