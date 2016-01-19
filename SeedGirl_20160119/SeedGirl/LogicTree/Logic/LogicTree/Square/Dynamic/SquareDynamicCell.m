//
//  SquareDynamicCell.m
//  SeedGirl
//
//  Created by Admin on 15/10/29.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "SquareDynamicCell.h"
#import "SquareDynamicHeaderView.h"
#import "SquareDynamicFooterView.h"
#import "SquareDynamicContentView.h"
#import "RecordData.h"

@interface SquareDynamicCell ()
//头部区域
@property (nonatomic, strong) SquareDynamicHeaderView *headerView;
//内容区域
@property (nonatomic, strong) SquareDynamicContentView *middleView;
//脚部区域
@property (nonatomic, strong) SquareDynamicFooterView *footerView;
//约束
@property (nonatomic, strong) MASConstraint *middleConstraint;
@end

@implementation SquareDynamicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSubviews];
    }
    return self;
}

//加载子视图
- (void)loadSubviews {
    //头部区域
    [self.contentView addSubview:self.headerView];
    //内容区域
    [self.contentView addSubview:self.middleView];
    //脚部区域
    [self.contentView addSubview:self.footerView];

    [self addConstraints];
}

//添加约束
- (void)addConstraints {
    WeakSelf;
    //顶部区域
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(104.0f);
    }];
    //内容区域
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerView.mas_bottom);
        make.left.right.equalTo(weakSelf.contentView);
    }];
    //脚部区域
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.middleView.mas_bottom);
        make.left.bottom.right.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(55.5f);
    }];
}

#pragma mark - Main
//设置显示数据
- (void)setShowData:(RecordData *)data {
    //设置个人信息
    [self.headerView setUserIcon:data.userIcon name:data.userName level:data.userLevel];
    //设置记录时间
    [self.headerView setRecordTime:data.recordTime];
    
    //设置记录文本
    [self.middleView setRecordText:data.recordText];
    //设置记录展示图片和视频图片
    [self.middleView setRecordPicList:data.picList video:data.videoThumbnail];
    
    //设置观看、评论、点赞数据
    [self.footerView setWatchCount:data.watchCount commentCount:data.commentCount praiseCount:data.praiseCount];
}

#pragma mark - lazyload
//头部视图
- (SquareDynamicHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[SquareDynamicHeaderView alloc] init];
        _headerView.backgroundColor = [UIColor clearColor];
    }
    return _headerView;
}
//内容区域
- (SquareDynamicContentView *)middleView {
    if (_middleView == nil) {
        _middleView = [[SquareDynamicContentView alloc] init];
        _middleView.backgroundColor = [UIColor clearColor];
    }
    return _middleView;
}
//脚部区域
- (SquareDynamicFooterView *)footerView {
    if (_footerView == nil) {
        _footerView = [[SquareDynamicFooterView alloc] init];
        _footerView.backgroundColor = [UIColor clearColor];
    }
    return _footerView;
}

@end
