//
//  LZBSegmentBarViewController.m
//  LZBSegmentBar
//
//  Created by zibin on 2017/8/14.
//  Copyright © 2017年 lzbgithubcode. All rights reserved.
//

#import "LZBSegmentBarViewController.h"
#import "LZBContentView.h"

#define kNavigationBarHeight    64

@interface LZBSegmentBarViewController ()<LZBSegmentBarDelegate,LZBContentViewDelegate>
@property (nonatomic, strong) LZBSegmentConfig *config;
@property (nonatomic, strong) NSArray<NSString *> *items;
@property (nonatomic, strong) NSArray<UIViewController *> *childVCs;

@property (nonatomic, strong) LZBContentView *contentView;

@property (nonatomic, assign) CGRect segmentBarFrame;
@property (nonatomic, assign) CGRect contentViewFrame;
@end

@implementation LZBSegmentBarViewController

- (instancetype)initWithSegmentConfig:(LZBSegmentConfig *)config items:(NSArray<NSString *> *)items childVCs:(NSArray<UIViewController *> *)childVCs
{
    if(self = [super init])
    {
        NSAssert(items.count != 0 || items.count == childVCs.count, @"子控制器的个数不一致");
        self.config = config == nil ? [LZBSegmentConfig defaultConfig] : config;
        self.items = items;
        self.childVCs = childVCs;
        
        //布局选项卡
        self.segmentBarFrame = CGRectMake(0, 0, self.config.isSegementInNavigationBar ? self.config.segmentBarWidth : self.view.bounds.size.width , self.config.segmentBarHeight);
        
        //布局内容View
        //过滤是否包含导航条,如果是在导航中，就必须包含导航条
        if(self.config.isSegementInNavigationBar)
            self.config.isContainNavigationBar = YES;
        
        CGFloat contentViewFrameX = kNavigationBarHeight;
        CGFloat contentViewFrameH = self.view.bounds.size.height - contentViewFrameX;
        if(self.config.isContainNavigationBar){
            if(self.config.isSegementInNavigationBar){
                contentViewFrameX = kNavigationBarHeight;
            }
            else{
                contentViewFrameX = CGRectGetMaxY(self.segmentBarFrame) + kNavigationBarHeight;
            }
        }else{
            contentViewFrameX = CGRectGetMaxY(self.segmentBarFrame);
        }
        contentViewFrameH = self.view.bounds.size.height - contentViewFrameX;
        
        
        
        self.contentViewFrame = CGRectMake(0, contentViewFrameX, self.view.bounds.size.width, contentViewFrameH);
        
        
        if(!self.config.isSegementInNavigationBar)
            [self.view addSubview:self.segmentBar];
        
        [self.view addSubview:self.contentView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)updateFrameWithLayoutSubViews:(CGRect)udpateFrame
{
    self.view.frame = udpateFrame;
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if(self.segmentBar.superview == self.view)
    {
        self.segmentBar.frame = self.segmentBarFrame;
        self.contentViewFrame = CGRectMake(0, CGRectGetMaxY(self.segmentBarFrame), self.view.bounds.size.width, self.view.bounds.size.height-CGRectGetMaxY(self.segmentBarFrame));
        self.contentView.frame = self.contentViewFrame;
        [self.contentView updateFrameWithLayoutSubViews:self.contentViewFrame];
        return;
    }
    
    CGRect contentFrame = CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height);
    self.contentView.frame = contentFrame;
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
        LZBSegmentBar *segmentBar = [[LZBSegmentBar alloc]initWithFrame:self.segmentBarFrame titles:self.items config:self.config];
        _segmentBar =segmentBar;
        _segmentBar.delegate = self;
    }
    return _segmentBar;
}

- (LZBContentView *)contentView
{
    if(_contentView == nil)
    {
        _contentView = [[LZBContentView alloc]initWithFrame:self.contentViewFrame childVcs:self.childVCs parentVc:self config:self.config];
        _contentView.delegate = self;
    }
    return _contentView;
}

@end
