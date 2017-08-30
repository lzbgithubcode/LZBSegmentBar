//
//  LZBTestTwoVC.m
//  LZBSegmentBar
//
//  Created by zibin on 2017/8/14.
//  Copyright © 2017年 lzbgithubcode. All rights reserved.
//

#import "LZBTestTwoVC.h"
#import "LZBSegmentBarViewController.h"
#import "UIColor+LZBSegmentColorExtension.h"

@interface LZBTestTwoVC ()
@property (nonatomic, weak) LZBSegmentBarViewController *segmentBarVC;
@property (nonatomic, weak) LZBSegmentConfig *config;
@end

@implementation LZBTestTwoVC
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
        pageStyleModel.isContainNavigationBar = YES;
        pageStyleModel.segmentBarWidth = 200;
        pageStyleModel.segmentBarHeight = 44;
        self.config = pageStyleModel;
        
        UIViewController *vc1 = [[UIViewController alloc] init];
        UIViewController*vc2 = [[UIViewController alloc] init];
        UIViewController *vc3 = [[UIViewController alloc] init];
        vc1.view.backgroundColor = [UIColor getRandomColor];
        vc2.view.backgroundColor = [UIColor getRandomColor];
        vc3.view.backgroundColor = [UIColor getRandomColor];
        
        LZBSegmentBarViewController *segmentBarVC = [[LZBSegmentBarViewController alloc]initWithSegmentConfig:pageStyleModel items:@[@"微信", @"QQ", @"支护宝"] childVCs:@[vc1, vc2, vc3]];
        _segmentBarVC = segmentBarVC;
    }
    return _segmentBarVC;
}

@end
