//
//  SquareDynamicPicView.m
//  SeedGirl
//
//  Created by Admin on 15/11/25.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "SquareDynamicPicView.h"
#import "SquareDynamicPicCell.h"

@interface SquareDynamicPicView () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
//子对象行间距
@property (nonatomic, assign) CGFloat minLineSpacing;
//子对象尺寸
@property (nonatomic, assign) CGSize minItemSize;
//图片列表
@property (nonatomic, strong) NSMutableArray *picList;
//图片列表数量
@property (nonatomic, assign) NSInteger picListCount;
//是否是视频
@property (nonatomic, assign) BOOL isVideo;
//图片最大数量
@property (nonatomic, assign) NSInteger picMaxCount;
@end

@implementation SquareDynamicPicView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //加载子视图
        [self loadSubviews];
    }
    return self;
}
//加载子视图
- (void)loadSubviews {
    [self addSubview:self.collectionView];
    [self addConstraints];
}
//添加约束
- (void)addConstraints {
    WeakSelf;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).insets(UIEdgeInsetsZero);
    }];
}

#pragma mark - Main
//设置基本属性
- (void)setMinLineSpacing:(CGFloat)minLineSpacing minItemSize:(CGSize)minItemSize {
    self.minLineSpacing = minLineSpacing;
    self.minItemSize = minItemSize;
}
//设置图片数据
- (void)setShowPicList:(NSMutableArray *)data {
    self.isVideo = NO;
    
    self.picList = data;
    self.picListCount = data.count;
    self.picMaxCount = data.count;
    if (self.picListCount > 4) {
        self.picListCount = 4;
    }
    [self.collectionView reloadData];
}
//设置视频数据
- (void)setShowVideoList:(NSMutableArray *)data {
    self.isVideo = YES;
    
    self.picList = data;
    self.picListCount = data.count;
    self.picMaxCount = data.count;
    if (self.picListCount > 4) {
        self.picListCount = 4;
    }
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView FlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.minItemSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.minLineSpacing;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.picListCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SquareDynamicPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SquareDynamicPicCell class]) forIndexPath:indexPath];
    
    NSString *picURL = [self.picList objectAtIndex:indexPath.row];
    [cell setShowPic:picURL isVideo:self.isVideo];
    
    if (indexPath.row == 3 && self.picMaxCount > 4) {
        [cell setPicMaxCount:self.picMaxCount];
    }
    
    return cell;
}

#pragma mark - lazyload
- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.sectionInset = UIEdgeInsetsZero;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollsToTop = NO;
        [_collectionView registerClass:[SquareDynamicPicCell class] forCellWithReuseIdentifier:NSStringFromClass([SquareDynamicPicCell class])];
        _collectionView.scrollEnabled = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}
@end
