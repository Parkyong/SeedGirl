//
//  FilterSelectView.m
//  SeedGirl
//
//  Created by ParkHunter on 15/10/11.
//  Copyright (c) 2015年 OASIS. All rights reserved.
//

#import "FilterSelectView.h"
#import "FilterCell.h"
@interface FilterSelectView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray           *nameArray;
@property (nonatomic, assign) FilterCell *beforeFilterCell;
@end
@implementation FilterSelectView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    self.nameArray = @[@"原始",@"LOMO",@"蓝调",
                       @"复古",@"哥特",@"锐化",
                       @"淡雅",@"酒红",@"黑白",
                       @"清宁",@"浪漫",@"梦幻"];
    [self addViews];
    [self addLimit];
    [self addValues];
}

#pragma mark 添加试图
- (void)addViews{
    [self addSubview:self.mainScrollView];
}

#pragma mark    添加值
- (void)addValues{
    CGFloat width = [Adaptor returnAdaptorValue:64];
    for (int i = 0; i < 12; i++) {
        FilterCell *cell = [[FilterCell alloc] initWithFrame:CGRectMake(width*i, 0, width, [Adaptor returnAdaptorValue:86])];
        cell.tag = i+300;
        cell.image = [[UIImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath]
                                                              stringByAppendingPathComponent:[NSString stringWithFormat:@"fli%d.png",300+i]]];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFilterAction:)];
        [cell addGestureRecognizer:tapGR];
        if (i == 0) {
            cell.type = FilterCellSelected;
            self.beforeFilterCell = cell;
        }
        cell.name  = self.nameArray[i];
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
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [Adaptor returnAdaptorValue:86])];
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator   = NO;
        _mainScrollView.bounces                        = NO;
        _mainScrollView.delegate                       = self;
        CGFloat width = [Adaptor returnAdaptorValue:64]*12;
        _mainScrollView.contentSize = CGSizeMake(width, 0);
    }
    return _mainScrollView;
}

- (void)selectFilterAction:(UITapGestureRecognizer *)tapGR{
    FilterCell *cell = (FilterCell *)tapGR.view;
    cell.type = FilterCellSelected;
    self.beforeFilterCell.type = FilterCellNormal;
    self.beforeFilterCell      = cell;
    NSInteger currentIndex     = cell.tag-300;
    CGPoint point              = CGPointZero;
    CGFloat itemWidth          = [Adaptor returnAdaptorValue:64];
    if (currentIndex == 0 || currentIndex >= 12-4) {
        if (currentIndex >= 12-4) {
            point = CGPointMake(itemWidth *7, 0);
        }
    }else{
        point = CGPointMake(currentIndex *itemWidth - itemWidth, 0);
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.mainScrollView.contentOffset = point;
    }];

    if (self.filterBlock != nil) {
        self.filterBlock(currentIndex);
    }
    
}

@end
