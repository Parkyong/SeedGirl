//
//  IndividualVideoHeaderView.m
//  SeedGirl
//
//  Created by Admin on 15/11/10.
//  Copyright © 2015年 OASIS. All rights reserved.
//

#import "IndividualVideoHeaderView.h"
#import "VideoSummaryData.h"
#import "UserData.h"

@interface IndividualVideoHeaderView ()

//标题
@property (strong, nonatomic) UILabel *titleLabel;
//概括视图
@property (strong, nonatomic) UIView *summaryView;
//已录制制式视频总数
@property (strong, nonatomic) UILabel *videoCountLabel;
//总计点播次数
@property (strong, nonatomic) UILabel *playCountLabel;
//视频请求总数
@property (strong, nonatomic) UILabel *requestCountLabel;
//接受请求总数
@property (strong, nonatomic) UILabel *acceptCountLabel;
//累计获得钻石总数
@property (strong, nonatomic) UILabel *diamondCountLabel;
//钻石总数
@property (strong, nonatomic) UILabel *myDiamondCountLabel;

@end

@implementation IndividualVideoHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //加载子视图
        [self loadSubviews];
    }
    return self;
}

//加载子视图
- (void)loadSubviews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.summaryView];
    [self.summaryView addSubview:self.videoCountLabel];
    [self.summaryView addSubview:self.playCountLabel];
    [self.summaryView addSubview:self.requestCountLabel];
    [self.summaryView addSubview:self.acceptCountLabel];
    [self.summaryView addSubview:self.diamondCountLabel];
    [self.summaryView addSubview:self.myDiamondCountLabel];

    [self addConstraints];
}

//添加约束
- (void)addConstraints {
    //label最大宽度
    CGFloat maxLabelWidth = CGRectGetWidth(self.bounds)/2 - 8.0f;
    WeakSelf;
    //标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(14.0f);
        make.left.and.right.equalTo(weakSelf);
    }];
    
    //概括视图
    [self.summaryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).with.offset(10.0f);
        make.left.and.bottom.and.right.equalTo(weakSelf);
    }];

    //已录制制式视频总数
    [self.videoCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.summaryView.mas_top).with.offset(17.0f);
        make.left.equalTo(weakSelf.summaryView.mas_left).with.offset(8.0f);
        make.width.mas_lessThanOrEqualTo(maxLabelWidth);
    }];
    
    //总计点播次数
    [self.playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.videoCountLabel.mas_centerY);
        make.left.equalTo(weakSelf.videoCountLabel.mas_right).with.offset(8.0f);
        make.right.equalTo(weakSelf.summaryView.mas_right).with.offset(-8.0f);
        make.width.mas_lessThanOrEqualTo(maxLabelWidth);
    }];

    //视频请求总数
    [self.requestCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.videoCountLabel.mas_bottom).with.offset(13.0f);
        make.left.equalTo(weakSelf.videoCountLabel.mas_left);
        make.width.mas_lessThanOrEqualTo(maxLabelWidth);
    }];
    
    //接受请求总数
    [self.acceptCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.requestCountLabel.mas_centerY);
        make.left.equalTo(weakSelf.playCountLabel.mas_left);
        make.right.equalTo(weakSelf.summaryView.mas_right).with.offset(-8.0f);
        make.width.mas_lessThanOrEqualTo(maxLabelWidth);
    }];
    
    //累计获得钻石总数
    [self.diamondCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.requestCountLabel.mas_bottom).with.offset(13.0f);
        make.left.equalTo(weakSelf.videoCountLabel.mas_left);
        make.bottom.equalTo(weakSelf.summaryView.mas_bottom).with.offset(-17.0f);
        make.width.mas_lessThanOrEqualTo(maxLabelWidth);
    }];
    
    //钻石总数
    [self.myDiamondCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.diamondCountLabel.mas_centerY);
        make.left.equalTo(weakSelf.playCountLabel.mas_left);
        make.right.equalTo(weakSelf.summaryView.mas_right).with.offset(-8.0f);
        make.width.mas_lessThanOrEqualTo(maxLabelWidth);
    }];
}

#pragma mark - Main
//设置显示数据
- (void)setShowData:(VideoSummaryData *)data {
    [self.videoCountLabel setText:[NSString stringWithFormat:@"已录制制式视频：%ld个",(long)data.videoCount]];
    [self.playCountLabel setText:[NSString stringWithFormat:@"总计点播次数：%ld次",(long)data.playCount]];
    [self.requestCountLabel setText:[NSString stringWithFormat:@"视频请求：%ld次",(long)data.requestCount]];
    [self.acceptCountLabel setText:[NSString stringWithFormat:@"已接受：%ld次",(long)data.acceptCount]];
    [self.diamondCountLabel setText:[NSString stringWithFormat:@"累计获得钻石数：%ld个",(long)data.videoDiamondCount+data.customVideoDiamondCount]];
    [self.myDiamondCountLabel setText:[NSString stringWithFormat:@"我的钻石总数：%ld个",(long)[[UserManager manager] userBalance]]];
}

- (void)setShowDefaultData {
    [self.videoCountLabel setText:@"已录制制式视频：0个"];
    [self.playCountLabel setText:@"总计点播次数：0次"];
    [self.requestCountLabel setText:@"视频请求：0次"];
    [self.acceptCountLabel setText:@"已接受：0次"];
    [self.diamondCountLabel setText:@"累计获得钻石数：0个"];
    [self.myDiamondCountLabel setText:@"我的钻石总数：0个"];
}

#pragma mark - lazyload
//标题
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 1;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.textColor = RGB(51, 51, 51);
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _titleLabel.text = @"概括（总）";
    }
    return _titleLabel;
}
//概括视图
- (UIView *)summaryView {
    if (_summaryView == nil) {
        _summaryView = [[UIView alloc] init];
        _summaryView.backgroundColor = [UIColor whiteColor];
        [_summaryView addShadowEffect];
    }
    return _summaryView;
}
//已录制制式视频总数
- (UILabel *)videoCountLabel {
    if (_videoCountLabel == nil) {
        _videoCountLabel = [[UILabel alloc] init];
        _videoCountLabel.backgroundColor = [UIColor clearColor];
        _videoCountLabel.textAlignment = NSTextAlignmentLeft;
        _videoCountLabel.numberOfLines = 1;
        _videoCountLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _videoCountLabel.textColor = RGB(51, 51, 51);
        _videoCountLabel.font = [UIFont systemFontOfSize:13.0f];
        _videoCountLabel.text = @"已录制制式视频：";
    }
    return _videoCountLabel;
}
//总计点播次数
- (UILabel *)playCountLabel {
    if (_playCountLabel == nil) {
        _playCountLabel = [[UILabel alloc] init];
        _playCountLabel.backgroundColor = [UIColor clearColor];
        _playCountLabel.textAlignment = NSTextAlignmentLeft;
        _playCountLabel.numberOfLines = 1;
        _playCountLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _playCountLabel.textColor = RGB(51, 51, 51);
        _playCountLabel.font = [UIFont systemFontOfSize:13.0f];
        _playCountLabel.text = @"总计点播次数：";
    }
    return _playCountLabel;
}
//视频请求总数
- (UILabel *)requestCountLabel {
    if (_requestCountLabel == nil) {
        _requestCountLabel = [[UILabel alloc] init];
        _requestCountLabel.backgroundColor = [UIColor clearColor];
        _requestCountLabel.textAlignment = NSTextAlignmentLeft;
        _requestCountLabel.numberOfLines = 1;
        _requestCountLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _requestCountLabel.textColor = RGB(51, 51, 51);
        _requestCountLabel.font = [UIFont systemFontOfSize:13.0f];
        _requestCountLabel.text = @"视频请求：";
    }
    return _requestCountLabel;
}
//接受请求总数
- (UILabel *)acceptCountLabel {
    if (_acceptCountLabel == nil) {
        _acceptCountLabel = [[UILabel alloc] init];
        _acceptCountLabel.backgroundColor = [UIColor clearColor];
        _acceptCountLabel.textAlignment = NSTextAlignmentLeft;
        _acceptCountLabel.numberOfLines = 1;
        _acceptCountLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _acceptCountLabel.textColor = RGB(51, 51, 51);
        _acceptCountLabel.font = [UIFont systemFontOfSize:13.0f];
        _acceptCountLabel.text = @"已接受：";
    }
    return _acceptCountLabel;
}
//累计获得钻石总数
- (UILabel *)diamondCountLabel {
    if (_diamondCountLabel == nil) {
        _diamondCountLabel = [[UILabel alloc] init];
        _diamondCountLabel.backgroundColor = [UIColor clearColor];
        _diamondCountLabel.textAlignment = NSTextAlignmentLeft;
        _diamondCountLabel.numberOfLines = 1;
        _diamondCountLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _diamondCountLabel.textColor = RGB(51, 51, 51);
        _diamondCountLabel.font = [UIFont systemFontOfSize:13.0f];
        _diamondCountLabel.text = @"累计获得钻石数：";
    }
    return _diamondCountLabel;
}
//钻石总数
- (UILabel *)myDiamondCountLabel {
    if (_myDiamondCountLabel == nil) {
        _myDiamondCountLabel = [[UILabel alloc] init];
        _myDiamondCountLabel.backgroundColor = [UIColor clearColor];
        _myDiamondCountLabel.textAlignment = NSTextAlignmentLeft;
        _myDiamondCountLabel.numberOfLines = 1;
        _myDiamondCountLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _myDiamondCountLabel.textColor = RGB(51, 51, 51);
        _myDiamondCountLabel.font = [UIFont systemFontOfSize:13.0f];
        _myDiamondCountLabel.text = @"我的钻石总数：";
    }
    return _myDiamondCountLabel;
}

@end
