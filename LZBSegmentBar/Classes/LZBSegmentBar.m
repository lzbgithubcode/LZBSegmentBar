//
//  LZBSegmentBar.m
//  LZBSegmentBar
//   作者：刘子彬（更多项目源码分享平台“开发者源代码” 微信号：developerCode 作者简介：iOS开发者，喜爱交流分享）
//   如遇到问题或有更好方案，请通过以下方式进行联系，同时可以加入讨论群
//   QQ群：490658347
//   简书：http://www.jianshu.com/u/268ed1ef819e
//   github : https://github.com/lzbgithubcode/LZBSegmentBar
//  Created by zibin on 2016/7/16.
//  Copyright © 2016年 lzbgithubcode. All rights reserved.
//

#import "LZBSegmentBar.h"
#import "UIColor+LZBSegmentColorExtension.h"

@interface LZBSegmentBar()

@property (nonatomic, strong) LZBSegmentConfig *config;
@property (nonatomic, strong) NSArray<NSString *> *items;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *indicatorLine;
@property (nonatomic, strong) UIView *separatorLine;
@property (nonatomic, strong) UIView *buttonMaskView;
@property (nonatomic, strong) NSMutableArray <UIButton *> *titleButtons;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *normalColor;
@property (nonatomic, strong) NSArray *selectColor;
@property (nonatomic, strong) NSArray *deltaColor;
@end

@implementation LZBSegmentBar
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)items config:(LZBSegmentConfig *)config
{
   if(self = [super initWithFrame:frame])
   {
       self.currentIndex = 0;
       self.config = config;
       self.items = items;
       [self setupUI];
   }
    return self;
}


#pragma mark - 初始化控件
- (void)setupUI
{
    [self addSubview:self.scrollView];
    
    [self setupTitlteButton];
    
    if(self.config.isShowIndicatorLine){
        [self setupBottomLine];
    }
    
    if(self.config.isNeedMask){
        [self setupMaskView];
    }
    
    if(self.config.isShowSeparatorLine){
        [self setupInitSeparatorLine];
    }
    
}

// 分割线
- (void)setupInitSeparatorLine
{
    [self addSubview:self.separatorLine];
    CGFloat separatorLineW = self.bounds.size.width;
    CGFloat separatorLineH = 0.5;
    CGFloat separatorLineX = 0;
    CGFloat separatorLineY = self.bounds.size.height - separatorLineH;
    self.separatorLine.frame = CGRectMake(separatorLineX, separatorLineY, separatorLineW, separatorLineH);
    
    
}

- (void)setupTitlteButton
{
    //1.初始化标题
    NSInteger count = self.items.count;
    for (NSInteger i = 0; i < count ; i++) {
        UIButton *tilteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString  *title = self.items[i];
        tilteButton.tag = i;
        [tilteButton setTitle:title forState:UIControlStateNormal];
        tilteButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [tilteButton setTitleColor:i == 0 ? self.config.itemSelectColor :self.config.itemNormalColor forState:UIControlStateNormal];
        tilteButton.titleLabel.font = self.config.itemFont;
        tilteButton.userInteractionEnabled = YES;
        [self.scrollView addSubview:tilteButton];
        [self.titleButtons addObject:tilteButton];
        [tilteButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
   //2.布局frame
    CGFloat titleLabX = 0;
    CGFloat titleLabY = 0;
    CGFloat titleLabW =  self.bounds.size.width/count;
    CGFloat titleLabH  = self.config.segmentBarHeight;
    for (NSInteger i = 0; i < self.titleButtons.count; i++) {
        UIButton *titleButton = self.titleButtons[i];
        if(self.config.isScrollEnable) //可以滚动
        {
            titleLabW = [titleButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : titleButton.titleLabel.font}].width;
            //计算位置
            titleLabX = i == 0 ? self.config.itemMargin : CGRectGetMaxX(self.titleButtons[i-1].frame) + self.config.itemMargin;
        }
        else  //不可以滚动
        {
            titleLabX = titleLabW * i;
        }

        titleButton.frame = CGRectMake(titleLabX, titleLabY, titleLabW, titleLabH);
    }

    //3.设置contensize
    if (self.config.isScrollEnable){
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(self.titleButtons.lastObject.frame) + self.config.itemMargin, 0);
    }
    else{
        self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, 0);
    }

    //4、设置初始位置方法
    if (self.config.isNeedScale){
        UIButton *titleButton = self.titleButtons.firstObject;
        titleButton.transform = CGAffineTransformMakeScale(self.config.maxScale, self.config.maxScale);
    }
    
}


- (void)setupBottomLine{
    [self.scrollView addSubview:self.indicatorLine];
    UIButton *titleButton = self.titleButtons.firstObject;
    if(titleButton == nil) return;
    if(self.config.allowIndicatorLineWidth){
        self.indicatorLine.bounds = CGRectMake(0, 0, self.config.indicatorLineWidth, self.config.indicatorLineHeight);
        CGPoint centerPoint = titleButton.center;
        centerPoint.y = self.bounds.size.height - self.indicatorLine.bounds.size.height-self.indicatorLine.bounds.size.height *0.5;
        self.indicatorLine.center= centerPoint;
    }else{
        self.indicatorLine.frame = titleButton.frame;
        CGRect frame = self.indicatorLine.frame;
        frame.size.height = self.config.indicatorLineHeight;
        frame.origin.y = self.bounds.size.height - frame.size.height;
        self.indicatorLine.frame = frame;
    }
}

- (void)setupMaskView{
    [self.scrollView addSubview:self.buttonMaskView];
    UIButton *titleButton = self.titleButtons.firstObject;
    if(titleButton == nil) return;
    CGFloat maskH = self.config.maskHeight;
    CGFloat maskY = (titleButton.frame.size.height - maskH) * 0.5;
    CGFloat maskX = titleButton.frame.origin.x;
    CGFloat maskW = titleButton.frame.size.width;
    
    if(self.config.isScrollEnable){
        maskX = maskX - self.config.maskInsetMargin;
        maskW = maskW + self.config.maskInsetMargin * 2;
    }
    self.buttonMaskView.frame = CGRectMake(maskX, maskY, maskW, maskH);
    self.buttonMaskView.layer.cornerRadius = self.config.maskLayerRadius;
    self.buttonMaskView.layer.masksToBounds = YES;
}


#pragma mark - 处理

- (void)setSegementDidSelectIndex:(NSInteger)selectIndex
{
    if(selectIndex >=self.titleButtons.count) return;
    UIButton *titleButton = self.titleButtons[selectIndex];
    [self titleButtonClick:titleButton];
}

- (void)titleButtonClick:(UIButton *)targertButton
{
    //1.检测label是否是nil
    if(targertButton == nil) return;
    if(targertButton.tag == self.currentIndex) return;
    
    //2.选中三部曲
    UIButton *lastButton = self.titleButtons[self.currentIndex];
    [lastButton setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
    [targertButton setTitleColor:self.config.itemSelectColor forState:UIControlStateNormal];
    self.currentIndex = targertButton.tag;
    
    //3.调整到中心位置
    [self adjustTargetOffset];
    
    //4.调用代理
    if([self.delegate respondsToSelector:@selector(segmentBar:didSelectIndex:)])
    {
        [self.delegate segmentBar:self didSelectIndex:self.currentIndex];
    }
    
    //5.点击滚动下滑线
    if(self.config.isShowIndicatorLine)
    {
        if(self.config.allowIndicatorLineWidth){
            [UIView animateWithDuration:0.25 animations:^{
                CGPoint centerPoint = self.indicatorLine.center;
                centerPoint.x = targertButton.center.x;
                self.indicatorLine.center = centerPoint;
            }];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                CGRect frame = self.indicatorLine.frame;
                frame.origin.x = targertButton.frame.origin.x;
                frame.size.width = targertButton.frame.size.width;
                self.indicatorLine.frame = frame;
            }];
        }
    }
    
    //6.点击放大字体
    if(self.config.isNeedScale){
        [UIView animateWithDuration:0.25 animations:^{
            lastButton.transform = CGAffineTransformIdentity;
            targertButton.transform = CGAffineTransformMakeScale(self.config.maxScale, self.config.maxScale);
        }];
    }
    
    //7.点击mask滚动
    if(self.config.isNeedMask){
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.buttonMaskView.frame;
            frame.size.width = self.config.isScrollEnable ? targertButton.frame.size.width + 2 * self.config.maskInsetMargin :  targertButton.frame.size.width;
            frame.origin.x = self.config.isScrollEnable ? targertButton.frame.origin.x - self.config.maskInsetMargin :  targertButton.frame.origin.x;
            self.buttonMaskView.frame = frame;
        }];
    }
}

//调整位置
- (void)adjustTargetOffset
{
    UIButton  *targetButton = self.titleButtons[self.currentIndex];
    CGFloat  offsetX = targetButton.center.x - self.scrollView.bounds.size.width * 0.5;
    if (offsetX < 0){
        offsetX = 0;
    }
    CGFloat  maxOffsetX = self.scrollView.contentSize.width - self.scrollView.bounds.size.width;
    if (offsetX > maxOffsetX){
        offsetX = maxOffsetX;
    }
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)contentViewDidScrollEndIndex:(NSInteger)index
{
    //1.滚动头部标题
    if(index >= self.titleButtons.count) return;
    self.currentIndex = index;
    [self adjustTargetOffset];
    
    //2.最后滚动结束颜色
    UIButton *titleButton = self.titleButtons[index];
    [titleButton setTitleColor:self.config.itemSelectColor forState:UIControlStateNormal];
    //2.1.拖动contentView，改变字体大小
    if (self.config.isNeedScale) {
        titleButton.transform = CGAffineTransformMakeScale(self.config.maxScale, self.config.maxScale);
    }
    
    //3.1其他滚动结束的颜色
    for (NSInteger i = 0; i < self.titleButtons.count; i++) {
        if(index == i)
            continue;
        UIButton *otherButton = self.titleButtons[i];
       [otherButton setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
        otherButton.transform = CGAffineTransformIdentity;;
    }
}
- (void)contentViewSourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress
{
    //1.获取变化的label
    UIButton *soureButton = self.titleButtons[sourceIndex];
    UIButton  *targeButton = self.titleButtons[targetIndex];
    
    //2.颜色渐变
    UIColor *sourceColor = [UIColor colorWithRed:([self.selectColor[0] floatValue] - [self.deltaColor[0] floatValue]) * progress
                                           green:([self.selectColor[1] floatValue] - [self.deltaColor[1] floatValue]) * progress
                                            blue:([self.selectColor[2] floatValue] - [self.deltaColor[2] floatValue]) * progress alpha:1.0];
    [soureButton setTitleColor:sourceColor forState:UIControlStateNormal];

    UIColor *targetColor = [UIColor colorWithRed:([self.normalColor[0] floatValue] + [self.deltaColor[0] floatValue]) * progress
                                           green:([self.normalColor[1] floatValue] + [self.deltaColor[1] floatValue]) * progress
                                            blue:([self.normalColor[2] floatValue] - [self.deltaColor[2] floatValue]) * progress alpha:1.0];
    
    [targeButton setTitleColor:targetColor forState:UIControlStateNormal];
    
    //4.拖动contentView，改变字体大小
    if (self.config.isNeedScale) {
        CGFloat deltaScale = self.config.maxScale - 1.0;
        soureButton.transform = CGAffineTransformMakeScale(self.config.maxScale - deltaScale * progress, self.config.maxScale - deltaScale * progress);
        targeButton.transform = CGAffineTransformMakeScale(1.0 + deltaScale * progress, 1.0 + deltaScale * progress);
    }
    
    CGFloat deltaWidth = targeButton.frame.size.width - soureButton.frame.size.width;
    CGFloat deltaX = targeButton.frame.origin.x - soureButton.frame.origin.x;
    //3.拖动contentView,下划线渐变
    if (self.config.isShowIndicatorLine) {
        if(self.config.allowIndicatorLineWidth){
            CGPoint centerPoint = self.indicatorLine.center;
            centerPoint.x = soureButton.center.x + deltaX * progress;
            self.indicatorLine.center = centerPoint;
        }else{
            CGRect frame = self.indicatorLine.frame;
            frame.size.width = soureButton.frame.size.width + deltaWidth * progress;
            frame.origin.x = soureButton.frame.origin.x + deltaX * progress;
            self.indicatorLine.frame = frame;
        }
       
    }
    
    //4.拖动contenView，mask渐变
    if(self.config.isNeedMask){
        CGRect maskFrame = self.buttonMaskView.frame;
        maskFrame.size.width = self.config.isScrollEnable ? soureButton.frame.size.width + 2 * self.config.maskInsetMargin + deltaWidth * progress : soureButton.frame.size.width + deltaWidth * progress;
        maskFrame.origin.x = self.config.isScrollEnable ? soureButton.frame.origin.x -  self.config.maskInsetMargin + deltaX * progress : soureButton.frame.origin.x + deltaX * progress;
        self.buttonMaskView.frame = maskFrame;
    }
}


#pragma mark- lazy
- (UIScrollView *)scrollView{
  if(_scrollView == nil)
  {
      _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
      _scrollView.showsHorizontalScrollIndicator = NO;
      _scrollView.scrollsToTop = NO;
  }
    return _scrollView;
}

- (UIView *)indicatorLine
{
  if(_indicatorLine == nil)
  {
      _indicatorLine = [UIView new];
      _indicatorLine.backgroundColor = self.config.indicatorColor;
  }
    return _indicatorLine;
}

- (UIView *)buttonMaskView
{
  if(_buttonMaskView == nil)
  {
      _buttonMaskView = [UIView new];
      _buttonMaskView.backgroundColor = self.config.maskColor;
  }
    return _buttonMaskView;
}

- (NSArray *)normalColor{
  if(_normalColor == nil)
  {
      _normalColor = [self.config.itemNormalColor getRGBValue];
  }
    return _normalColor;
}

- (NSArray *)selectColor
{
  if(_selectColor == nil)
  {
      _selectColor = [self.config.itemSelectColor getRGBValue];
  }
    return _selectColor;
}

- (NSArray *)deltaColor
{
  if(_deltaColor == nil)
  {
      CGFloat rdelta = [self.selectColor[0] floatValue] - [self.normalColor[0] floatValue];
      CGFloat gdelta =  [self.selectColor[1] floatValue] - [self.normalColor[1] floatValue];
      CGFloat bdelta =  [self.selectColor[2] floatValue] - [self.normalColor[2] floatValue];
      _deltaColor = @[@(rdelta),@(gdelta),@(bdelta)];
  }
    return _deltaColor;
}
- (NSMutableArray<UIButton *> *)titleButtons
{
   if(_titleButtons == nil)
   {
       _titleButtons = [NSMutableArray array];
   }
    return _titleButtons;
}
- (UIView *)separatorLine
{
    if(!_separatorLine){
        _separatorLine = [[UIView alloc]init];
        _separatorLine.backgroundColor = self.config.separatorLineColor;
    }
    return _separatorLine;
}

@end
