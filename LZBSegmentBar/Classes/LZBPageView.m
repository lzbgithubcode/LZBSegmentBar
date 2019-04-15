//
//  LZBPageView.m
//  LZBSegmentBar
//   作者：刘子彬（更多项目源码分享平台“开发者源代码” 微信号：developerCode 作者简介：iOS开发者，喜爱交流分享）
//   如遇到问题或有更好方案，请通过以下方式进行联系，同时可以加入讨论群
//   QQ群：490658347
//   简书：http://www.jianshu.com/u/268ed1ef819e
//   github : https://github.com/lzbgithubcode/LZBSegmentBar
//  Created by zibin on 2016/7/16.
//  Copyright © 2016年 lzbgithubcode. All rights reserved.
//

#import "LZBPageView.h"
#import "LZBSegmentBar.h"
#import "LZBContentView.h"

@interface LZBPageView() <LZBSegmentBarDelegate,LZBContentViewDelegate>
@property (nonatomic, strong) LZBSegmentConfig *config;
@property (nonatomic, strong) NSArray<NSString *> *items;
@property (nonatomic, strong) NSArray<UIViewController *> *childVCs;
@property (nonatomic, strong) UIViewController *parentVc;

@property (nonatomic, strong) LZBSegmentBar *segmentBar;
@property (nonatomic, strong) LZBContentView *contentView;

@property (nonatomic, assign) CGRect segmentBarFrame;
@property (nonatomic, assign) CGRect contentViewFrame;
@end

@implementation LZBPageView
- (instancetype)initWithFrame:(CGRect)frame segmentConfig:(LZBSegmentConfig *)config items:(NSArray<NSString *> *)items childVCs:(NSArray<UIViewController *> *)childVCs parentVc:(UIViewController *)parentVc
{
    if(self = [super initWithFrame:frame])
    {
        self.config = config == nil ? [LZBSegmentConfig defaultConfig] : config;
        self.items = items;
        self.childVCs = childVCs;
        self.parentVc = parentVc;
        [self setupUI];
    }
    return self;
}

- (void)setPageViewDidSelectIndex:(NSInteger)defautIndex
{
    if(defautIndex >= self.childVCs.count)
    {
        NSAssert(defautIndex < self.childVCs.count,@"defautIndex beyond range");
        return;
    }
    [self.segmentBar setSegementDidSelectIndex:defautIndex];
}

- (void)updateFrameWithLayoutSubViews:(CGRect)udpateFrame
{
    self.frame = udpateFrame;
    CGFloat contentViewFrameX = 0;
    CGFloat contentViewFrameY = CGRectGetMaxY(self.segmentBarFrame);
    CGFloat contentViewFrameW = self.bounds.size.width;
    CGFloat contentViewFrameH =  self.bounds.size.height - CGRectGetMaxY(self.segmentBarFrame);
    CGRect contentViewFrame = CGRectMake(contentViewFrameX, contentViewFrameY, contentViewFrameW, contentViewFrameH);
    self.contentViewFrame = contentViewFrame;
    self.contentView.frame = self.contentViewFrame;
    [self.contentView updateFrameWithLayoutSubViews:self.contentViewFrame];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


#pragma mark- pravite

- (void)setupUI
{
    //1.创建标题栏
    CGRect segmentBarFrame = CGRectMake(0, 0, self.bounds.size.width, self.config.segmentBarHeight);
    self.segmentBarFrame = segmentBarFrame;
    self.segmentBar.frame = segmentBarFrame;
    self.segmentBar.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.segmentBar];
    
    //2.创建内容
    CGRect contentViewFrame = CGRectMake(0, CGRectGetMaxY(segmentBarFrame), self.bounds.size.width, self.bounds.size.height - CGRectGetMaxY(segmentBarFrame));
    self.contentViewFrame = contentViewFrame;
    self.contentView.frame = contentViewFrame;
    [self addSubview:self.contentView];
    
    //3.设置代理
    self.segmentBar.delegate = self;
    self.contentView.delegate = self;
    
    
}

#pragma mark - LZBSegmentBarDelegate

- (void)segmentBar: (LZBSegmentBar *)segmentBar didSelectIndex: (NSInteger)toIndex
{
    [self.contentView segmentDidSelectTargetIndex:toIndex];
}

- (void)conentView:(LZBContentView *)contenView didScrollEndIndex:(NSInteger)index
{
    [self.segmentBar contentViewDidScrollEndIndex:index];
}

- (void)conentView:(LZBContentView *)contenView sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress
{
    [self.segmentBar contentViewSourceIndex:sourceIndex targetIndex:targetIndex progress:progress];
}

#pragma mark - lazy
- (LZBSegmentBar *)segmentBar
{
  if(_segmentBar == nil)
  {
      _segmentBar = [[LZBSegmentBar alloc]initWithFrame:self.segmentBarFrame titles:self.items config:self.config];
  }
    return _segmentBar;
}

- (LZBContentView *)contentView
{
  if(_contentView == nil)
  {
      _contentView = [[LZBContentView alloc]initWithFrame:self.contentViewFrame childVcs:self.childVCs parentVc:self.parentVc config:self.config];
  }
    return _contentView;
}

@end
