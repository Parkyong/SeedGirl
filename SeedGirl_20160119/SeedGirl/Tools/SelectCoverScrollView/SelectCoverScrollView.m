//
//  SelectCoverScrollView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/16.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "SelectCoverScrollView.h"
@interface SelectCoverScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIImageView      *beforeCell;
@property (nonatomic, strong) NSMutableArray       *images;
@end

@implementation SelectCoverScrollView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self addViews];
    [self addLimit];
    self.images = [NSMutableArray array];
}

#pragma mark 添加试图
- (void)addViews{
    [self addSubview:self.mainScrollView];
}

#pragma mark 设置图片
- (void)setCoverImages:(NSArray *)images{
    if (images.count == 0) {
        return;
    }
    [self.images addObjectsFromArray:images];
    CGFloat width = [Adaptor returnAdaptorValue:52];
    for (int i = 0; i < 12; i++) {
        UIImageView *cell = [[UIImageView alloc] initWithFrame:CGRectMake(width*i, 0, width, width)];
        cell.userInteractionEnabled = YES;
        cell.image = [images objectAtIndex:i];
        cell.tag   = 300+i;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectCoverAction:)];
        [cell addGestureRecognizer:tapGR];
        [self.mainScrollView addSubview:cell];
    }
}

#pragma mark 添加限制
- (void)addLimit{
    WeakSelf;
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.right.equalTo(weakSelf.mas_right);
    }];
}

#pragma mark    懒加载对象
- (UIScrollView *)mainScrollView{
    if (_mainScrollView == nil) {
        CGFloat width = [Adaptor returnAdaptorValue:52];
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, width)];
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator   = NO;
        _mainScrollView.bounces                        = NO;
        _mainScrollView.delegate                       = self;
        _mainScrollView.contentSize = CGSizeMake(width*12, 0);
    }
    return _mainScrollView;
}

- (void)selectCoverAction:(UITapGestureRecognizer *)tapGR{
    UIImageView *cell = (UIImageView *)tapGR.view;
    self.beforeCell            = cell;
    NSInteger currentIndex     = cell.tag-300;
    CGPoint point              = CGPointZero;
    CGFloat itemWidth          = [Adaptor returnAdaptorValue:52];
    if (currentIndex == 0 || currentIndex >= 12-6) {
        if (currentIndex >= 12-6) {
            point = CGPointMake(itemWidth *6, 0);
        }
    }else{
        point = CGPointMake(currentIndex *itemWidth - itemWidth, 0);
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.mainScrollView.contentOffset = point;
    }];
    
    if (self.coverBlock != nil) {
        self.coverBlock([self.images objectAtIndex:currentIndex]);
    }
}
@end
