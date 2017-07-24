//
//  LZBContentView.m
//  LZBSegmentBar
//
//  Created by zibin on 2016/7/16.
//  Copyright © 2016年 lzbgithubcode. All rights reserved.
//

#import "LZBContentView.h"

static NSString *kLZBContentViewCellID = @"kLZBContentViewCellID";

@interface LZBContentView() <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) LZBSegmentConfig *config;
@property (nonatomic, strong) NSArray<UIViewController *> *childVcs;
@property (nonatomic, strong) UIViewController *parentVc;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, assign) CGFloat startOffsetX;
@property (nonatomic, assign) BOOL isForbidDelegate;

@end

@implementation LZBContentView
- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray <UIViewController *>*)childVcs parentVc:(UIViewController *)parentVc config:(LZBSegmentConfig *)config
{
  if(self = [super initWithFrame:frame])
  {
      self.startOffsetX = 0;
      self.isForbidDelegate = NO;
      self.childVcs = childVcs;
      self.config = config;
      self.parentVc = parentVc;
      [self setupUI];
  }
    return self;
}

- (void)setupUI
{
    //1.将子控制器加入到父控制器
    for (UIViewController *childVC in self.childVcs) {
        [self.parentVc addChildViewController:childVC];
    }
    [self addSubview:self.collectionView];
}


#pragma mark - handel
- (void)segmentDidSelectTargetIndex:(NSInteger)targetIndex
{
    //点击禁止代理
    self.isForbidDelegate = YES;
    
    if(targetIndex < self.childVcs.count)
    {
        //1.选中标题对应的indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:targetIndex inSection:0];
        //2.滚动到对应的cell
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
}

- (void)contentViewScrollDidEnd
{
    NSInteger currentIndex = self.collectionView.contentOffset.x/self.collectionView.bounds.size.width;
    if([self.delegate respondsToSelector:@selector(conentView:didScrollEndIndex:)])
    {
        [self.delegate conentView:self didScrollEndIndex:currentIndex];
    }
}

#pragma mark- UICollectionViewDelegate
//滚动完成监听 - 减速完成
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self contentViewScrollDidEnd];
}
 //滚动完成监听 - 拖拽完成
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate)
    {
        [self contentViewScrollDidEnd];
    }
}
 //记录起始位置的offsetX
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.startOffsetX = self.collectionView.contentOffset.x;
    self.isForbidDelegate = NO;
}

//滚动进度
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //当前偏移量
    CGFloat currentOffsetX = self.collectionView.contentOffset.x;
    if(self.isForbidDelegate) return;
    if(currentOffsetX == self.startOffsetX) return;
    
    NSInteger  soureIndex = 0;
    NSInteger  targetIndex = 0;
    CGFloat  progress = 0;
    CGFloat collectionViewWidth = self.collectionView.bounds.size.width;
    //判断左右滑动
    if (currentOffsetX > self.startOffsetX){  //左滑
        soureIndex = currentOffsetX/collectionViewWidth;
        targetIndex = soureIndex + 1;
        if (targetIndex >= self.childVcs.count){
            targetIndex = self.childVcs.count - 1;
        }
        //进度
        progress = (currentOffsetX - self.startOffsetX)/collectionViewWidth;
        
        if ((currentOffsetX - self.startOffsetX) == collectionViewWidth){
            targetIndex = soureIndex;
        }
    }
    else  //右滑
    {
        targetIndex = currentOffsetX/collectionViewWidth;
        soureIndex = targetIndex + 1;
        progress = (self.startOffsetX - currentOffsetX)/collectionViewWidth;
        
    }
    
    if([self.delegate respondsToSelector:@selector(conentView:sourceIndex:targetIndex:progress:)])
    {
        [self.delegate conentView:self sourceIndex:soureIndex targetIndex:targetIndex progress:progress];
    }
}




#pragma mark- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childVcs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLZBContentViewCellID forIndexPath:indexPath];
    
    //移除之前的Veiw
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    //增加新的View
    if(indexPath.item < self.childVcs.count)
    {
        UIViewController  *subChildvc =  self.childVcs[indexPath.item];
        [cell.contentView addSubview:subChildvc.view];
    }
    return cell;
}




#pragma mark - lazy
- (UICollectionView *)collectionView
{
  if(_collectionView == nil)
  {
      _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
      _collectionView.dataSource = self;
      _collectionView.delegate = self;
      [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kLZBContentViewCellID];
      _collectionView.pagingEnabled = YES;
      _collectionView.showsHorizontalScrollIndicator = NO;
      _collectionView.bounces = NO;
      _collectionView.scrollsToTop = NO;
  }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout
{
  if(_flowLayout == nil)
  {
      _flowLayout = [[UICollectionViewFlowLayout alloc]init];
      _flowLayout.itemSize = self.bounds.size;
      _flowLayout.minimumLineSpacing = 0;
      _flowLayout.minimumInteritemSpacing = 0;
      _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  }
    return _flowLayout;
}
@end
