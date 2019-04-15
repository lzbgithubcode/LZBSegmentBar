//
//  LZBTestOneVC.m
//  LZBSegmentBar
//
//  Created by zibin on 2017/8/14.
//  Copyright © 2017年 lzbgithubcode. All rights reserved.
//

#import "LZBTestOneVC.h"
#import "UIColor+LZBSegmentColorExtension.h"
#import "LZBSegmentConfig.h"
#import <LZBSegmentBar/LZBSegmentBarViewController.h>

@interface LZBTestOneVC ()
@property (nonatomic, weak) LZBSegmentBarViewController *segmentBarVC;
@property (nonatomic, weak) LZBSegmentConfig *config;
@end

@implementation LZBTestOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpUI];
}


/**
 设置UI界面
 */
- (void)setUpUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addChildViewController:self.segmentBarVC];
    [self.view addSubview:self.segmentBarVC.view];
    
    // 1. 设置导航栏背景颜色, 以及titleView内容视图
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, self.config.segmentBarWidth, self.config.segmentBarHeight);
    self.navigationItem.titleView = self.segmentBarVC.segmentBar;
    
    // 2. 设置控制器内容视图
    self.segmentBarVC.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
}



- (LZBSegmentBarViewController *)segmentBarVC
{
    if(_segmentBarVC == nil)
    {
        LZBSegmentConfig  *pageStyleModel = [LZBSegmentConfig defaultConfig];
        pageStyleModel.isScrollEnable = NO;
        pageStyleModel.isNeedScale = YES;
        pageStyleModel.isShowIndicatorLine = YES;
        pageStyleModel.isSegementInNavigationBar = YES;
        pageStyleModel.segmentBarWidth = 200;
        pageStyleModel.segmentBarHeight = 44;
        self.config = pageStyleModel;
        
        UIViewController *vc1 = [[UIViewController alloc] init];
        UIViewController*vc2 = [[UIViewController alloc] init];
        UIViewController *vc3 = [[UIViewController alloc] init];
        vc1.view.backgroundColor = [UIColor getRandomColor];
        vc2.view.backgroundColor = [UIColor getRandomColor];
        vc3.view.backgroundColor = [UIColor getRandomColor];

        
        LZBSegmentBarViewController *segmentBarVC = [[LZBSegmentBarViewController alloc]initWithSegmentConfig:pageStyleModel items:@[@"李白", @"杜甫", @"白居易"] childVCs:@[vc1, vc2, vc3]];
        _segmentBarVC = segmentBarVC;
    }
    return _segmentBarVC;
}

@end
