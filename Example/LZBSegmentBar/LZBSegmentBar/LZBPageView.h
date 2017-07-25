//
//  LZBPageView.h
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
#import "LZBSegmentConfig.h"

@interface LZBPageView : UIView


/**
  初始化页面信息

 @param frame pageView的frame
 @param config config模型
 @param items 标题数据
 @param childVCs 子控制数组
 @param parentVc 父控制器
  @return 返回实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame segmentConfig:(LZBSegmentConfig *)config items:(NSArray<NSString *> *)items childVCs:(NSArray<UIViewController *> *)childVCs parentVc:(UIViewController *)parentVc;


/**
  设置LZBPageView选中某个索引标题，默认是0

 @param defautIndex    默认选中索引
 */
- (void)setPageViewDidSelectIndex:(NSInteger)defautIndex;
@end
