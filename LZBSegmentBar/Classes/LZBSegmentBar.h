//
//  LZBSegmentBar.h
//  LZBSegmentBar
//
//  Created by zibin on 2016/7/16.
//  Copyright © 2016年 lzbgithubcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZBSegmentConfig.h"
@class LZBSegmentBar;

@protocol LZBSegmentBarDelegate <NSObject>

/**
 代理方法, 告诉外界, 内部的点击数据
 
 @param segmentBar segmentBar
 @param toIndex    选中的索引(从0开始)
 */
- (void)segmentBar: (LZBSegmentBar *)segmentBar didSelectIndex: (NSInteger)toIndex;

@end

@interface LZBSegmentBar : UIView

/** 代理 */
@property (nonatomic, weak)  id<LZBSegmentBarDelegate> delegate;


/**
 初始化LZBSegmentBar

 @param frame frame
 @param items 标题数组
 @param config 配置模型
 @return 返回实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)items config :(LZBSegmentConfig *)config;



/**
  设置默认点击标题

 @param selectIndex  索引
 */
- (void)setSegementDidSelectIndex:(NSInteger)selectIndex;



/**
 处理contentView 滚动结束代理

 @param index 滚动结束索引
 */
- (void)contentViewDidScrollEndIndex:(NSInteger)index;

/**
  处理contentView 滚动过程代理

 @param sourceIndex 源索引
 @param targetIndex 目标索引
 @param progress 滚动进度
 */
- (void)contentViewSourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress;
@end
