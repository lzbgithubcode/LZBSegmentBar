//
//  LZBViewController.m
//  LZBSegmentBar
//
//  Created by lzbgithubcode on 07/16/2016.
//  Copyright (c) 2016 lzbgithubcode. All rights reserved.
//

#import "LZBViewController.h"
#import "LZBPageView.h"
#import "UIView+LZBSegmentFrameLayout.h"
#import "UIColor+LZBSegmentColorExtension.h"

@interface LZBViewController ()

@property (nonatomic, strong) NSMutableArray *childVcs;
@property (nonatomic, strong) LZBPageView *pageView;
@end

@implementation LZBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGRect pageFrame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64);
    //1.创建标题
    //NSArray *titles = @[@"英雄联盟",@"火蓝",@"提姆队长",@"史前巨鳄"];
    
    NSArray *titles = @[@"英雄联盟",@"火蓝",@"提姆队长",@"史前巨鳄",@"洛克萨斯之手",@"狗头",@"武器"];
    //2.创建控制器数组
    
    for (NSInteger i = 0; i < titles.count; i++) {
        UIViewController *vc = [[UIViewController alloc]init];
        vc.view.backgroundColor = [UIColor getRandomColor];
        UILabel *label = [UILabel new];
        label.text = titles[i];
        label.textColor = [UIColor blueColor];
        label.center = CGPointMake(150, 200);
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        [vc.view addSubview:label];
        [self.childVcs addObject:vc];
    }
    
    //3.创建样式
    LZBSegmentConfig  *pageStyleModel = [LZBSegmentConfig defaultConfig];
    pageStyleModel.isScrollEnable = YES;
    pageStyleModel.isNeedScale = YES;
    pageStyleModel.isShowIndicatorLine = YES;
   // pageStyleModel.isNeedMask = YES;
    
    //4.创建pageView
    LZBPageView *pageView = [[LZBPageView alloc]initWithFrame:pageFrame segmentConfig:pageStyleModel items:titles childVCs:self.childVcs parentVc:self];
    self.pageView = pageView;
    
    [self.view addSubview:pageView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.pageView setPageViewDidSelectIndex:1];
}

- (NSMutableArray *)childVcs
{
    if(_childVcs == nil)
    {
        _childVcs = [NSMutableArray array];
    }
    return _childVcs;
}

@end
