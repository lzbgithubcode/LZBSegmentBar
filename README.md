# LZBSegmentBar

[![CI Status](http://img.shields.io/travis/lzbgithubcode/LZBSegmentBar.svg?style=flat)](https://travis-ci.org/lzbgithubcode/LZBSegmentBar)
[![Version](https://img.shields.io/cocoapods/v/LZBSegmentBar.svg?style=flat)](http://cocoapods.org/pods/LZBSegmentBar)
[![License](https://img.shields.io/cocoapods/l/LZBSegmentBar.svg?style=flat)](http://cocoapods.org/pods/LZBSegmentBar)
[![Platform](https://img.shields.io/cocoapods/p/LZBSegmentBar.svg?style=flat)](http://cocoapods.org/pods/LZBSegmentBar)

## LZBSegmentBar

* 类似与今日头条、网易新闻的选项卡

## Contents
* LZBSegmentConfig  选项卡样式配置
* LZBPageView    主View
* LZBSegmentBar    选项卡Bar
* LZBContentView   滚动内容View

## <a id="How to use LZBSegmentBar"></a>How to use LZBSegmentBar
* 1.Installation with CocoaPods：`pod 'LZBSegmentBar'`
* 
* 2.Drag All files in the `LZBSegmentBar` folder to project
* Import the main file：`#import "LZBPageView.h"`

* More information of App can focus on：[摸着石头过河_崖边树](http://www.jianshu.com/u/268ed1ef819e)

## <a id="Example"></a>Example
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


##  Contact Author
If you have any good Suggestions or questions, please contact with mee
QQ : 490658347
简书：[摸着石头过河_崖边树](http://www.jianshu.com/u/268ed1ef819e)
lzbgithubcode, 1835064412@qq.com

## License

LZBSegmentBar is available under the MIT license. See the LICENSE file for more info.
