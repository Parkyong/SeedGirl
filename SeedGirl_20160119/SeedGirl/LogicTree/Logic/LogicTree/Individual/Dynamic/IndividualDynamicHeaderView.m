//
//  IndividualDynamicHeaderView.m
//  SeedGirl
//
//  Created by Admin on 16/1/13.
//  Copyright © 2016年 OASIS. All rights reserved.
//

#import "IndividualDynamicHeaderView.h"

@interface IndividualDynamicHeaderView ()
//头像背景
@property (strong, nonatomic) UIImageView *iconBgImage;
//头像
@property (strong, nonatomic) UIImageView *iconImage;
//昵称
@property (strong, nonatomic) UILabel *nameLabel;
//奖励
@property (assign, nonatomic, getter=isHasReward) BOOL hasReward;
@property (strong, nonatomic) UIButton *rewardButton;
//时间图片
@property (strong, nonatomic) UIImageView *timeImage;
//时间
@property (strong, nonatomic) UILabel *timeLabel;
@end

@implementation IndividualDynamicHeaderView

- (instancetype)init {
    if (self = [super init]) {
        //加载子视图
        [self loadSubviews];
    }
    return self;
}

//加载子视图
- (void)loadSubviews {
    [self addSubview:self.iconBgImage];
    [self addSubview:self.iconImage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.rewardButton];
    [self addSubview:self.timeImage];
    [self addSubview:self.timeLabel];
    
    [self addConstraints];
}
//添加约束
- (void)addConstraints {
    WeakSelf;
    //头像相关
    [self.iconBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(74.0f, 74.0f));
    }];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.iconBgImage);
        make.size.mas_equalTo(CGSizeMake(64.0f, 64.0f));
    }];
    _iconImage.layer.cornerRadius = 64.0f/2;
    //昵称
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconBgImage.mas_right).with.offset(15);
        make.bottom.equalTo(weakSelf.iconBgImage.mas_bottom).with.offset(-43.0f);
        make.right.lessThanOrEqualTo(weakSelf.rewardButton.mas_left).with.offset(-2);
    }];
    //奖励
    [self.rewardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-20);
        make.centerY.equalTo(weakSelf.nameLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(51.0f, 45.5f));
    }];
    //时间相关
    [self.timeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconBgImage.mas_top).with.offset(43.0f);
        make.left.equalTo(weakSelf.iconBgImage.mas_right).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.timeImage.mas_right).with.offset(6);
        make.right.equalTo(weakSelf.mas_right).with.offset(-20.0f);
        make.centerY.equalTo(weakSelf.timeImage.mas_centerY);
    }];
}

#pragma mark - Main
//设置个人信息
- (void)setUserIcon:(NSString *)url name:(NSString *)name {
    NSURL *iconURL = [NSURL URLWithString:url];
    [_iconImage sd_setImageWithURL:iconURL placeholderImage:[UIImage imageNamed:@"icon_girl.png"]];
    [_nameLabel setText:name];
}
//设置记录时间和是否领取过奖励
- (void)setRecordTime:(NSString *)time getReward:(BOOL)status {
    [_timeLabel setText:time];
    
    self.hasReward = status;
    if (status) {
        [self.rewardButton setBackgroundImage:[UIImage imageWithContentOfFile:@"record_reward_get.png"] forState:UIControlStateNormal];
        [self.rewardButton setTitle:@"已领" forState:UIControlStateNormal];
    } else {
        [self.rewardButton setBackgroundImage:[UIImage imageWithContentOfFile:@"record_reward.png"] forState:UIControlStateNormal];
        [self.rewardButton setTitle:nil forState:UIControlStateNormal];
    }
}

#pragma mark - UIResponse Event
//奖励按钮点击事件
- (void)rewardButtonClick:(id)sender {
    if (self.isHasReward == NO && self.rewardBlock) {
        self.rewardBlock();
    }
}

#pragma mark - lazyload
//头像背景
- (UIImageView *)iconBgImage {
    if (_iconBgImage == nil) {
        _iconBgImage = [[UIImageView alloc] init];
        _iconBgImage.backgroundColor = [UIColor clearColor];
        _iconBgImage.image = [UIImage imageWithContentOfFile:@"record_userIcon.png"];
    }
    return _iconBgImage;
}
//头像
- (UIImageView *)iconImage {
    if (_iconImage == nil) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.backgroundColor = [UIColor clearColor];
        _iconImage.contentMode = UIViewContentModeScaleAspectFill;
        _iconImage.layer.masksToBounds = YES;
    }
    return _iconImage;
}
//昵称
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = RGB(51, 51, 51);
        _nameLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        _nameLabel.numberOfLines = 1;
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLabel;
}
//奖励
- (UIButton *)rewardButton {
    if (_rewardButton == nil) {
        _rewardButton = [[UIButton alloc] init];
        _rewardButton.backgroundColor = [UIColor clearColor];
        [_rewardButton setTitleColor:RGB(232,93,119) forState:UIControlStateNormal];
        _rewardButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_rewardButton addTarget:self action:@selector(rewardButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rewardButton;
}
//时间图片
- (UIImageView *)timeImage {
    if (_timeImage == nil) {
        _timeImage = [[UIImageView alloc] init];
        _timeImage.backgroundColor = [UIColor clearColor];
        _timeImage.image = [UIImage imageWithContentOfFile:@"record_time.png"];
    }
    return _timeImage;
}
//时间
- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = RGB(172, 172, 172);
        _timeLabel.font = [UIFont systemFontOfSize:16.0f];
        _timeLabel.numberOfLines = 1;
        _timeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _timeLabel;
}

@end
