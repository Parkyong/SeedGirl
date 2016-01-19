//
//  ExperienceAndLevelReferenceView.m
//  SeedGirl
//
//  Created by ParkHunter on 16/1/14.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "ExperienceAndLevelReferenceView.h"
#import "HeaderView.h"
@interface ExperienceAndLevelReferenceView ()
@property (nonatomic, strong) UIScrollView   *mainScroView;
@property (nonatomic, strong) HeaderView      *levelHeader;
@property (nonatomic, strong) HeaderView *experienceHeader;
@end
@implementation ExperienceAndLevelReferenceView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

#pragma mark    初始化
- (void)initialize{
    [self addViews];
//    [self addLimits];
    self.backgroundColor = RGB(240, 242, 245);
}

#pragma mark    添加试图
- (void)addViews{
    [self addSubview:self.mainScroView];
    [self.mainScroView addSubview:self.levelTableView];
    [self.mainScroView addSubview:self.experienceTableView];
    self.levelTableView.tableHeaderView = self.levelHeader;
    self.experienceTableView.tableHeaderView = self.experienceHeader;
}

#pragma mark    添加限制
- (void)addLimits{
    WeakSelf;
    [self.mainScroView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.right.equalTo(weakSelf.mas_right);
    }];
    
    [self.levelTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mainScroView.mas_top).with.offset(9);
        make.left.equalTo(weakSelf.mainScroView.mas_left).with.offset(9);
        make.right.equalTo(weakSelf.mainScroView.mas_right).with.offset(-9);
        make.height.mas_equalTo([Adaptor returnAdaptorValue:47]*10);
    }];
    
    [self.experienceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.levelTableView.mas_top).with.offset(9);
        make.left.equalTo(weakSelf.levelTableView.mas_left);
        make.right.equalTo(weakSelf.levelTableView.mas_right);
        make.bottom.equalTo(weakSelf.mainScroView.mas_bottom);
    }];
}

#pragma mark    懒加载对象
- (UIScrollView *)mainScroView{
    if (_mainScroView == nil) {
        _mainScroView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _mainScroView.contentSize = CGSizeMake(0, [Adaptor returnAdaptorValue:47]*(11+8)+9*3);
        _mainScroView.showsVerticalScrollIndicator   = NO;
        _mainScroView.showsHorizontalScrollIndicator = NO;
        _mainScroView.backgroundColor = [UIColor clearColor];//RGB(240, 242, 245);
    }
    return _mainScroView;
}

- (UITableView *)levelTableView{
    if (_levelTableView == nil) {
        _levelTableView = [[UITableView alloc] initWithFrame:CGRectMake(9, 9,
                                                                        SCREEN_WIDTH-9*2,
                                                                        [Adaptor returnAdaptorValue:47]*11)];
        _levelTableView.scrollEnabled                  = NO;
        _levelTableView.showsHorizontalScrollIndicator = NO;
        _levelTableView.showsVerticalScrollIndicator   = NO;
        _levelTableView.tag                            = 100;
        _levelTableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;
        _levelTableView.backgroundColor                = [UIColor whiteColor];
    }
    return _levelTableView;
}

- (UITableView *)experienceTableView{
    if (_experienceTableView == nil) {
        _experienceTableView = [[UITableView alloc] initWithFrame:CGRectMake(9,CGRectGetMaxY(self.levelTableView.frame)+9,
                                                                             SCREEN_WIDTH-9*2,
                                                                             [Adaptor returnAdaptorValue:47]*8)];
        _experienceTableView.scrollEnabled                  = NO;
        _experienceTableView.showsHorizontalScrollIndicator = NO;
        _experienceTableView.showsVerticalScrollIndicator   = NO;
        _experienceTableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;
        _experienceTableView.tag                            = 200;
        _experienceTableView.backgroundColor                = [UIColor whiteColor];
    }
    return _experienceTableView;
}

- (HeaderView *)levelHeader{
    if (_levelHeader == nil) {
        _levelHeader = [[HeaderView alloc] initWithFrame:CGRectMake(9, 0,
                                                                    SCREEN_WIDTH-9*2,
                                                                    [Adaptor returnAdaptorValue:47])];
        [_levelHeader setTitle:@"等级对应特权"];
    }
    return _levelHeader;
}

- (HeaderView *)experienceHeader{
    if (_experienceHeader == nil) {
        _experienceHeader = [[HeaderView alloc] initWithFrame:CGRectMake(9, 0,
                                                                    SCREEN_WIDTH-9*2,
                                                                    [Adaptor returnAdaptorValue:47])];
        [_experienceHeader setTitle:@"如何获取经验"];
    }
    return _experienceHeader;
}
@end
