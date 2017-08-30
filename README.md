# LZBSegmentBar

[![CI Status](http://img.shields.io/travis/lzbgithubcode/LZBSegmentBar.svg?style=flat)](https://travis-ci.org/lzbgithubcode/LZBSegmentBar)
[![Version](https://img.shields.io/cocoapods/v/LZBSegmentBar.svg?style=flat)](http://cocoapods.org/pods/LZBSegmentBar)
[![License](https://img.shields.io/cocoapods/l/LZBSegmentBar.svg?style=flat)](http://cocoapods.org/pods/LZBSegmentBar)
[![Platform](https://img.shields.io/cocoapods/p/LZBSegmentBar.svg?style=flat)](http://cocoapods.org/pods/LZBSegmentBar)

## LZBSegmentBar

* 类似与今日头条、网易新闻的选项卡
* OC版本：当前为OC版本[OC版选项卡](https://github.com/lzbgithubcode/LZBSegmentBar)
* swift版本：[Swift版选项卡](https://github.com/lzbgithubcode/LZBPageView)
* 效果图
![image](https://github.com/lzbgithubcode/LZBSegmentBar/raw/master/screenshotImage/LZBPageView.gif)

![image](https://github.com/lzbgithubcode/LZBSegmentBar/raw/master/screenshotImage/LZBPageViewContent.gif)

## 类的简单介绍
* LZBSegmentConfig  选项卡样式配置
* LZBPageView    主View
* LZBSegmentBar    选项卡Bar
* LZBContentView   滚动内容View
* LZBSegmentBarViewController  选项卡控制器（可以把选项卡单独增加在导航条上面）


## 使用CocoaPods导入

```ruby
pod "LZBSegmentBar"
```
## 手动导入
将`LZBSegmentBar`文件夹中的所有源代码拽入项目中

导入主头文件：`#import "LZBPageView"` 或者 `#import "LZBSegmentBarViewController"`


## <a id="Example"></a>具体使用
```objc
// 1.创建标题
NSArray *titles = @[@"英雄联盟",@"火蓝",@"提姆队长",@"史前巨鳄",@"洛克萨斯之手",@"狗头",@"武器"];
 //2.创建需要使用的控制器数组
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
// 3.创建选项卡配置样式
    LZBSegmentConfig  *pageStyleModel = [LZBSegmentConfig defaultConfig];
    pageStyleModel.isScrollEnable = YES;  //是否可以滚动
    pageStyleModel.isNeedScale = YES;    //是否需要放大
    pageStyleModel.isShowIndicatorLine = YES;  //是否需要下划线
   // pageStyleModel.isNeedMask = YES;   //是否需要遮罩
// 4.创建pageView，增加到父类View，可以使用
    LZBPageView *pageView = [[LZBPageView alloc]initWithFrame:pageFrame segmentConfig:pageStyleModel items:titles childVCs:self.childVcs parentVc:self];
    self.pageView = pageView;
    [self.view addSubview:pageView];
```

## LZBSegmentBarViewController的使用

* 选项卡在导航条上

```objc
/**
设置UI界面
*/
- (void)setUpUI {
self.automaticallyAdjustsScrollViewInsets = NO;
[self addChildViewController:self.segmentBarVC];
[self.view addSubview:self.segmentBarVC.view];

// 1. 设置导航栏背景颜色, 以及titleView内容视图
self.navigationController.navigationBar.backgroundColor = [UIColor grayColor];
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

```

* 选项卡在内容中,与LZBPageView使用一样

```objc 
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


```


## 联系作者

* QQ : 1835064412
* 简书：[摸着石头过河_崖边树](http://www.jianshu.com/u/268ed1ef819e)
* email:1835064412@qq.com

## 期待
* 如果在使用过程中遇到BUG，希望你能联系我，谢谢
* 如果您觉得这个这个demo对您有所帮助，请给我一颗❤️❤️,star一下
* 如果你想了解更多的开源姿势，可以关注公众号‘开发者源代码’

![image](https://github.com/lzbgithubcode/LZBSegmentBar/raw/master/screenshotImage/developerCoder08.jpg)
