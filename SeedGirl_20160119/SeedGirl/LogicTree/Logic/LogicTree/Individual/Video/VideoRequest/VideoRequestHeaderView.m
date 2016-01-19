//
//  VideoRequestHeaderView.m
//  SeedGirl
//
//  Created by Admin on 15/11/16.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "VideoRequestHeaderView.h"
#import "VideoSummaryData.h"

@interface VideoRequestHeaderView ()

//请求数标签
@property (strong, nonatomic) UILabel *requestCountLabel;
//获得钻石数标签
@property (strong, nonatomic) UILabel *diamondCountLabel;

@end

@implementation VideoRequestHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //加载子视图
        [self loadSubviews];
    }
    return self;
}

//加载子视图
- (void)loadSubviews {
    [self addSubview:self.requestCountLabel];
    [self addSubview:self.diamondCountLabel];
    
    [self addConstraint];
}

//添加约束
- (void)addConstraint {
    WeakSelf;
    [self.requestCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(14.0f);
        make.left.equalTo(weakSelf.mas_left).with.offset(10);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-15.0f);
    }];
    
    [self.diamondCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(14.0f);
        make.left.equalTo(weakSelf.requestCountLabel.mas_right).with.offset(2);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-15.0f);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
    }];
}

#pragma mark - Main

//设置显示数据
- (void)setShowData:(VideoSummaryData *)data {
    [_requestCountLabel setText:[NSString stringWithFormat:@"请求总数：%ld",(long)data.requestCount]];
    [_diamondCountLabel setText:[NSString stringWithFormat:@"累计获得钻石：%ld",(long)data.customVideoDiamondCount]];
}

#pragma mark - lazyload

//请求总数
- (UILabel *)requestCountLabel {
    if (_requestCountLabel == nil) {
        _requestCountLabel = [[UILabel alloc] init];
        _requestCountLabel.backgroundColor = [UIColor clearColor];
        _requestCountLabel.textAlignment = NSTextAlignmentLeft;
        _requestCountLabel.textColor = RGB(51, 51, 51);
        _requestCountLabel.font = [UIFont systemFontOfSize:15.0f];
        _requestCountLabel.text = @"请求总数：";
    }
    return _requestCountLabel;
}

//钻石总数
- (UILabel *)diamondCountLabel {
    if (_diamondCountLabel == nil) {
        _diamondCountLabel = [[UILabel alloc] init];
        _diamondCountLabel.backgroundColor = [UIColor clearColor];
        _diamondCountLabel.textAlignment = NSTextAlignmentRight;
        _diamondCountLabel.textColor = RGB(51, 51, 51);
        _diamondCountLabel.font = [UIFont systemFontOfSize:15.0f];
        _diamondCountLabel.text = @"累计获得钻石：";
    }
    return _diamondCountLabel;
}

@end
